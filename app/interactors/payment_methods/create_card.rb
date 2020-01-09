require_dependency("create_stripe_card")

class CreateCard
  include Interactor

  delegate :card_params, :current_user, :card_token, to: :context

  def call
    PaymentMethod.transaction do
      @card = Stripe::PaymentMethods::CreateStripeCard.new(card_token, current_user).call

      context.payment_method = current_user.payment_methods.create(build_payment_method_params)
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      context.fail!(message: e.message)
  end

  private

  def build_payment_method_params
    card_params.merge(stripe_id: @card.id)
  end
end
