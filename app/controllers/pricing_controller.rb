class PricingController < ApplicationController
  def index
    redirect_to root_path and return if user_signed_in? && current_user.has_library_access?
    @plans = Plan.all.order(:amount)
  end
end
