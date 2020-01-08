class DeattachPaymentMethod
  attr_reader :current_user

  def initialize(current_user)
    @current_user = current_user
  end

  def call
    card_id = Stripe::Customer.retrieve(current_user.stripe_id).sources.data.last.id
    Stripe::Customer.delete_source(current_user.stripe_id, card_id)
  end
end
