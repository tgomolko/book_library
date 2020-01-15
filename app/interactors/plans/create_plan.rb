require_dependency("create_stripe_plan")

class CreatePlan
  include Interactor

  delegate :plan_params, :product_stripe_id, to: :context

  def call
    Plan.transaction do
      @stripe_plan = Stripe::Plans::CreateStripePlan.new(plan_params, product_stripe_id).call

      context.plan = Plan.create!(build_plan_params)
    end

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError => e
      rollback
      context.fail!(message: e.message)
  end

  private

  def rollback
    Stripe::Plans::DestroyStripePlan.new(@stripe_plan.id).call if @stripe_plan.id
  end

  def build_plan_params
    plan_params.merge(stripe_id: @stripe_plan.id)
  end
end
