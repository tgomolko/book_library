class CancelStripeSubscription
  attr_reader :subscription_stripe_id

  def initialize(subscription_stripe_id)
    @subscription_stripe_id = subscription_stripe_id
  end

  def call
    Stripe::Subscription.retrieve(subscription_stripe_id).delete
  end
end
