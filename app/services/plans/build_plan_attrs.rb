class BuildPlanAttrs
  attr_reader :plan, :stripe_plan_id

  def initialize(plan, stripe_plan_id)
    @plan = plan
    @stripe_plan_id = stripe_plan_id
  end

  def call
    plan.stripe_id = stripe_plan_id
  end
end
