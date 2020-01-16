# frozen_string_literal: true

module Stripe
  module PaymentMethods
    class Destroy
      attr_reader :card_stripe_id, :customer_id

      def initialize(card_stripe_id, customer_id)
        @card_stripe_id = card_stripe_id
        @customer_id = customer_id
      end

      def call
        Stripe::Customer.delete_source(customer_id, card_stripe_id)
      end
    end
  end
end
