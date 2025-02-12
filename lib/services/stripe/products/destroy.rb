# frozen_string_literal: true

module Stripe
  module Products
    class Destroy
      attr_reader :product_stripe_id

      def initialize(product_stripe_id)
        @product_stripe_id = product_stripe_id
      end

      def call
        Stripe::Product.retrieve(product_stripe_id).delete
      end
    end
  end
end
