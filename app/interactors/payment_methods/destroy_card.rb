require_dependency("destroy_stripe_card")

class DestroyCard
  include Interactor

  delegate :payment_method, :customer_id, to: :context

  def call
   PaymentMethod.transaction do
      Stripe::PaymentMethods::DestroyStripeCard.new(payment_method.stripe_id, customer_id).call
      payment_method.destroy
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      context.fail!(message: e.message)
  end
end
