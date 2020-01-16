require_dependency("destroy")

class DestroyPlan
  include Interactor

  delegate :plan, to: :context

  def call
    Plan.transaction do
      Stripe::Plans::Destroy.new(plan.stripe_id).call

      plan.destroy
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      context.fail!(message: e.message)
  end
end
