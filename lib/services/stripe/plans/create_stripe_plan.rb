module Stripe
  class CreateStripePlan
    attr_reader :plan_params, :product_stripe_id

    def initialize(plan_params, product_stripe_id)
      @plan_params = plan_params
      @product_stripe_id = product_stripe_id
    end

    def call
      Stripe::Plan.create(build_stripe_plan_params)
    end

    private

    def build_stripe_plan_params
      {
        nickname: plan_params[:nickname],
        product: product_stripe_id,
        amount: plan_params[:amount],
        currency: plan_params[:currency],
        interval: plan_params[:interval]
     }
    end
  end
end
