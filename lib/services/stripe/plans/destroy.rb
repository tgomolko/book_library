# frozen_string_literal: true

module Stripe
  module Plans
    class Destroy
      attr_reader :plan_stripe_id

      def initialize(plan_stripe_id)
        @plan_stripe_id = plan_stripe_id
      end

      def call
        Stripe::Plan.retrieve(plan_stripe_id).delete
      end
    end
  end
end
