require_dependency("destroy")

class DestroyPlan
  include Interactor

  delegate :plan, to: :context

  def call
    Stripe::Plans::Destroy.new(plan.stripe_id).call

    plan.destroy

    rescue ActiveRecord::Rollback, Stripe::StripeError => error
      context.fail!(message: error.message)
  end
end
