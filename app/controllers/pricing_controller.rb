class PricingController < ApplicationController
  def index
   # redirect_to root_path and return if user_signed_in? && current_user.subscriptions.any?
    @plans = Plan.all
  end
end
