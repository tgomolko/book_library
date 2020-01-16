# frozen_string_literal: true

module Stripe
  module Subscriptions
    class Cancel
      attr_reader :subscription_stripe_id

      def initialize(subscription_stripe_id)
        @subscription_stripe_id = subscription_stripe_id
      end

      def call
        Stripe::Subscription.retrieve(subscription_stripe_id).delete
      end
    end
  end
end
