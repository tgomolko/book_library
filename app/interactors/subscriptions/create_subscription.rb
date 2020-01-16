require_dependency("create")

class CreateSubscription
  include Interactor

  delegate :subscription_params, :current_user, :stripe_token, :plan_stripe_id, to: :context

  def call
    Subscription.transaction do
      @stripe_subscription = Stripe::Subscriptions::Create.new(current_user, plan_stripe_id, stripe_token).call

      context.subscription = current_user.subscriptions.create!(build_subscriptions_params)
    end

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError => error
      rollback if error.kind_of?(ActiveRecord::ActiveRecordError)
      context.fail!(message: error.message)
  end

  private

  def rollback
    Stripe::Subscriptions::Cancel.new(@stripe_subscription.id).call if @stripe_subscription.id
  end

  def build_subscriptions_params
    subscription_params.merge(stripe_id: @stripe_subscription.id)
  end
end
