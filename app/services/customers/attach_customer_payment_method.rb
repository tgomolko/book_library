class AttachCustomerPaymentMethod
  attr_reader :customer, :card_token

  def initialize(customer, card_token)
    @customer = customer
    @card_token = card_token
  end

  def call
    customer.source = card_token
    customer.save
  end
end
