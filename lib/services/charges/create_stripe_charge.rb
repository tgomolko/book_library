# frozen_string_literal: true

module Stripe
  module Charges
    class CreateStripeCharge
      attr_reader :amount, :source

      def initialize(amount, source)
        @amount = amount
        @source = source
      end

      def call
        Stripe::Charge.create({
          amount: stripe_amount,
          currency: 'usd',
          source:  source
        })
      end
      private

      def stripe_amount
        amount * 100
      end
    end
  end
end
