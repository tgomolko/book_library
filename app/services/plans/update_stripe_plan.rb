class UpdateStripePlan
  attr_reader :plan_stripe_id, :plan_params

  def initialize(plan_stripe_id, plan_params)
    @plan_stripe_id = plan_stripe_id
    @plan_params = plan_params
  end

  def call
   # Stripe::Plan.update(plan_stripe_id, prepare_params.to_h)
  end

  private

  def prepare_params
    plan_params.delete(:product_id)
    plan_params
  end
end