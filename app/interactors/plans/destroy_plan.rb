require_dependency("destroy_stripe_plan")

class DestroyPlan
  include Interactor

  delegate :plan, to: :context

  def call
    Plan.transaction do
      Stripe::Plans::DestroyStripePlan.new(plan.stripe_id).call
      plan.destroy
    end

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError => e
      context.fail!(message: e.message)
  end

end
