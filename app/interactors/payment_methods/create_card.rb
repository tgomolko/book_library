require_dependency("#{Rails.root}/lib/services/stripe/payment_methods/create")

class CreateCard
  include Interactor

  delegate :card_params, :current_user, :card_token, to: :context

  def call
    @card = Stripe::PaymentMethods::Create.new(card_token, current_user).call

    context.payment_method = current_user.payment_methods.create!(build_payment_method_params)

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError => error
      rollback if error.kind_of?(ActiveRecord::ActiveRecordError)
      context.fail!(message: error.message)
  end

  private

  def rollback
    Stripe::PaymentMethods::Destroy.new(@card.id, current_user.id).call if @card.id
  end

  def build_payment_method_params
    card_params.merge(stripe_id: @card.id)
  end
end
