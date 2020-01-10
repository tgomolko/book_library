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
          amount: amount,
          currency: 'usd',
          source:  source,
        })
      end
    end
  end
end
