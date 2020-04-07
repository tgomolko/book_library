require_dependency("#{Rails.root}/lib/services/stripe/payment_methods/destroy")

class DestroyCard
  include Interactor

  delegate :payment_method, :customer_id, to: :context

  def call
    Stripe::PaymentMethods::Destroy.new(payment_method.stripe_id, customer_id).call

    payment_method.destroy

    rescue ActiveRecord::Rollback, Stripe::StripeError => error
      context.fail!(message: error.message)
  end
end
