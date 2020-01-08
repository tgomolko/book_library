module Stripe
  class AttachPaymentMethod
    attr_reader :payment_method_stripe_id, :current_user

    def initialize(payment_method_stripe_id, current_user)
      @payment_method_stripe_id = payment_method_stripe_id
      @current_user = current_user
    end

    def call
      Stripe::CreateStripeCustomer.new(current_user).call unless current_user.stripe_id
binding.pry
      Stripe::PaymentMethod.attach(payment_method_stripe_id, customer: current_user.stripe_id)
      binding.pry
    end
  end
end
