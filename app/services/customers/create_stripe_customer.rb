class CreateStripeCustomer
  attr_reader :current_user, :card_token

  def initialize(current_user, card_token)
    @current_user = current_user
    @card_token = card_token
  end

  def call
    ActiveRecord::Base.transaction do
      unless current_user.stripe_id
        customer = Stripe::Customer.create({"email": current_user.email})
        current_user.update(stripe_id: customer.id)
      end
      AttachCustomerPaymentMethod.new(current_user.stripe_id, card_token).call
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      flash.alert = e.message
  end
end
