require_dependency("cancel_stripe_subscription")

class CancelSubscription
  include Interactor

  delegate :subscription, to: :context

  def call
    Subscription.transaction do
      Stripe::Subscriptions::CancelStripeSubscription.new(subscription.stripe_id).call
      subscription.destroy
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      context.fail!(message: e.message)
  end
end
