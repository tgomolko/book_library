class BuildStripePlanParams
  attr_reader :plan_params, :product_stripe_id

  def initialize(plan_params, product_stripe_id)
    @plan_params = plan_params
    @product_stripe_id = product_stripe_id
  end

  def call
    plan_params[:product] = plan_params.delete(:product_id)
    plan_params[:product] = product_stripe_id
    plan_params
  end
end
