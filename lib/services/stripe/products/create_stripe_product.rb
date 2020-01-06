# frozen_string_literal: true

module Stripe
  class CreateStripeProduct
    attr_reader :product_params

    def initialize(product_params)
      @product_params = product_params
    end

    def call
      Stripe::Product.create(build_stripe_product_params)
    end

    private

    def build_stripe_product_params
      stripe_product_params = product_params
      stripe_product_params[:type] = stripe_product_params.delete :product_type
      stripe_product_params
    end
  end
end
