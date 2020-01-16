require_dependency("destroy")

class DestroyCard
  include Interactor

  delegate :payment_method, :customer_id, to: :context

  def call
   PaymentMethod.transaction do
      Stripe::PaymentMethods::Destroy.new(payment_method.stripe_id, customer_id).call

      payment_method.destroy
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => error
      context.fail!(message: error.message)
  end
end
