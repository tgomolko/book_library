# frozen_string_literal: true

module Stripe
  module PaymentMethods
    class Create
      attr_reader :current_user, :card_token

      def initialize(card_token, current_user)
        @card_token = card_token
        @current_user = current_user
      end

      def call
        Stripe::Customers::Create.new(current_user).call unless current_user.stripe_id

        Stripe::Customer.create_source(current_user.stripe_id, { source: card_token })
      end
    end
  end
end
