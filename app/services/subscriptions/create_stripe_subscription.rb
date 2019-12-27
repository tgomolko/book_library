class CreateStripeSubscription
  attr_reader :subscription, :plan_stripe_id, :current_user, :stripe_token

  def initialize(subscription, plan_stripe_id, current_user, stripe_token)
    @subscription = subscription
    @plan_stripe_id = plan_stripe_id
    @current_user = current_user
    @stripe_token = stripe_token
  end

  def call
    CreateStripeCustomer.new(current_user, stripe_token).call if current_user.payment_methods.blank?

    ActiveRecord::Base.transaction do
      stripe_subscription = Stripe::Subscription.create({ customer: current_user.stripe_id, items: [{plan: plan_stripe_id}] })
      subscription.stripe_id = stripe_subscription.id
    end
  end
end
