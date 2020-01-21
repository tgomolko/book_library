require_dependency("cancel")

class CancelSubscription
  include Interactor

  delegate :subscription, to: :context

  def call
    Stripe::Subscriptions::Cancel.new(subscription.stripe_id).call

    subscription.destroy

    rescue ActiveRecord::Rollback, Stripe::StripeError => error
      context.fail!(message: error.message)
  end
end
