require_dependency("destroy")

class DestroyPlan
  include Interactor

  delegate :plan, to: :context

  def call
    Plan.transaction do
      Stripe::Plans::Destroy.new(plan.stripe_id).call

      plan.destroy
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => error
      context.fail!(message: error.message)
  end
end
