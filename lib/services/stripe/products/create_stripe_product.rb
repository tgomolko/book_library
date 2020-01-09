# frozen_string_literal: true

module Stripe
  module Products
    class CreateStripeProduct
      attr_reader :product_params

      def initialize(product_params)
        @product_params = product_params
      end

      def call
        Stripe::Product.create(name: product_params[:name], type: product_params[:product_type])
      end
    end
  end
end
