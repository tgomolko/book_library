class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_plan, only: [:new, :create]
  before_action :load_subscription, only: [:show, :destroy]

  def index
    @subscriptions = current_user.subscriptions.order("created_at DESC")
  end

  def create
    result = CreateSubscription.call(
      subscription_params: subscription_params,
      current_user: current_user,
      stripe_token: params[:stripeToken],
      plan_stripe_id: @plan.stripe_id
    )

    if result.success?
      redirect_to result.subscription, notice: "You was successfully subsribed"
    else
      flash.now.alert = result.message
      render :new
    end
  end


  def destroy
    result = CancelSubscription.call(subscription: @subscription)

    if result.success?
      redirect_to subscriptions_path, notice: 'Subscription was successfully canceled'
    else
      redirect_to result.subscription, alert: "#{result.message}"
    end
  end

  private

  def load_plan
    @plan = Plan.find(params[:plan_id])
  end

  def load_subscription
    @subscription = Subscription.find(params[:id])
  end

  def subscription_params
    { plan_id: @plan.id, product_id: @plan.product_id }
  end
end
