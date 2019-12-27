class AttachCustomerPaymentMethod
  attr_reader :current_user_stripe_id, :card_token

  def initialize(current_user_stripe_id, card_token)
    @current_user_stripe_id = current_user_stripe_id
    @card_token = card_token
  end

  def call
    Stripe::Customer.create_source(current_user_stripe_id, { source: card_token } )
  end
end
