require_dependency("create_stripe_plan")

class CreatePlan
  include Interactor

  delegate :plan_params, :product_stripe_id, to: :context

  def call
    Plan.transaction do
      @stripe_plan = Stripe::CreateStripePlan.new(plan_params, product_stripe_id).call

      context.plan = Plan.create(build_plan_params)
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      context.fail!(message: e.message)
  end

  private

  def build_plan_params
    plan_params.merge(stripe_id: @stripe_plan.id)
  end
end
