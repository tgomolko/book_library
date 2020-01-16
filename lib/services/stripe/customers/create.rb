# frozen_string_literal: true

module Stripe
  module Customers
    class Create
      attr_reader :current_user

      def initialize(current_user)
        @current_user = current_user
      end

      def call
        User.transaction do
          customer = Stripe::Customer.create(email: current_user.email)
          current_user.update(stripe_id: customer.id)
        end
      end
    end
  end
end
