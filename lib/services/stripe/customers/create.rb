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
          @customer = Stripe::Customer.create(email: current_user.email)
          current_user.update(stripe_id: @customer.id)
        end

        rescue ActiveRecord::ActiveRecordError, Stripe::StripeError  => error
          rollback if error.kind_of?(ActiveRecord::ActiveRecordError)
          context.fail!(message: error.message)
      end

      def rollback
        Stripe::Customer.reretrieve(@customer.id).delete
      end
    end
  end
end
