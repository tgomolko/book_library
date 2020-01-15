require_dependency("create_stripe_subscription")

class CreateSubscription
  include Interactor

  delegate :subscription_params, :current_user, :stripe_token, :plan_stripe_id, to: :context

  def call
    Subscription.transaction do
      @stripe_subscription = Stripe::Subscriptions::CreateStripeSubscription.new(current_user, plan_stripe_id, stripe_token).call

      context.subscription = current_user.subscriptions.create!(build_subscriptions_params)
    end

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError => e
      rollback
      context.fail!(message: e.message)
  end

  private

  def rollback
    Stripe::Subscriptions::CancelStripeSubscription.new(@stripe_subscription.id).call if @stripe_subscription.id
  end

  def build_subscriptions_params
    subscription_params.merge(stripe_id: @stripe_subscription.id)
  end
end
