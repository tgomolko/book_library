require_dependency("cancel")

class CancelSubscription
  include Interactor

  delegate :subscription, to: :context

  def call
    Subscription.transaction do
      Stripe::Subscriptions::Cancel.new(subscription.stripe_id).call

      subscription.destroy
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      context.fail!(message: e.message)
  end
end
