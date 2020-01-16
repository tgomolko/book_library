# frozen_string_literal: true

module Stripe
  module Subscriptions
    class Create
      attr_reader :current_user, :plan_stripe_id, :card_token

      def initialize(current_user, plan_stripe_id, card_token)
        @current_user = current_user
        @plan_stripe_id = plan_stripe_id
        @card_token = card_token
      end

      def call
        Stripe::PaymentMethods::CreateStripeCard.new(card_token, current_user).call unless current_user.stripe_id

        Stripe::Subscription.create({ customer: current_user.stripe_id, items: [{plan: plan_stripe_id}] })
      end
    end
  end
end
