class UserDashboardController < ApplicationController
  def dashboard
    @payment_method = current_user.payment_methods.last
  end
end
