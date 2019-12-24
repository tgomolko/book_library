class CreateStripePlan
  attr_reader :plan, :product_stripe_id, :plan_params

  def initialize(plan, plan_params, product_stripe_id)
    @plan = plan
    @plan_params = plan_params
    @product_stripe_id = product_stripe_id
  end

  def call
    stripe_plan = Stripe::Plan.create(BuildStripePlanParams.new(plan_params, product_stripe_id).call)

    BuildPlanAttrs.new(plan, stripe_plan.id).call
  end

end
