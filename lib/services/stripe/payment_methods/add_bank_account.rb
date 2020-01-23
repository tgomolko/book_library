# frozen_string_literal: true

module Stripe
  module PaymentMethods
    class AddBankAccount
      attr_reader :bank_account_token, :customer_stripe_id

      def initialize(bank_account_token, customer_stripe_id)
        @bank_account_token = bank_account_token
        @customer_stripe_id = customer_stripe_id
      end

      def call
        Stripe::Customer.create_source(customer_stripe_id, { source: bank_account_token })
      end
    end
  end
end
