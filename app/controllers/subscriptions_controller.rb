class SubscriptionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_plan, only: [:new, :create]
  before_action :load_subscription, only: [:show, :destroy]

  def index
    @subscriptions = current_user.subscriptions.order("created_at DESC")
  end

  def create
    @subscription = current_user.subscriptions.build(subscription_params)

    ActiveRecord::Base.transaction do
      CreateStripeSubscription.new(@subscription, @plan.stripe_id, current_user, params[:stripeToken]).call
      @subscription.save
    end

    redirect_to subscriptions_path, notice: 'You have successfully subscribe'

    rescue Stripe::StripeError, ActiveRecord::Rollback => e
      flash.alert = e.message
      render :new
  end

  def destroy
    ActiveRecord::Base.transaction do
      CancelStripeSubscription.new(@subscription.stripe_id).call
      @subscription.destroy
    end

    redirect_to subscriptions_path, notice: 'Subscription was successfully canceled'

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      flash.alert = e.message
      redirect_to subscriptions_path
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
