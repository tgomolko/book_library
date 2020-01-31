class SubscriptionPresenter
  attr_reader :subscription

  def initialize(subscription)
    @subscription = subscription
  end

  def created_at
    subscription.created_at.localtime.strftime("%d.%m.%Y, %H:%M")
  end

  def plan_title
    subscription.plan.nickname
  end

  def product_title
    subscription.product.name
  end

  def subscription_plan_price
    subscription.plan.amount / 100
  end

  def subscription_plan_currency
    subscription.plan.currency
  end

  def subscription_plan_interval
    subscription.plan.interval
  end
end
