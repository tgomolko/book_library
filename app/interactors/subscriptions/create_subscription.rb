require_dependency("create_stripe_subscription")

class CreateSubscription
  include Interactor

  delegate :subscription_params, :current_user, :stripe_token, to: :context

  def call

  end
end
