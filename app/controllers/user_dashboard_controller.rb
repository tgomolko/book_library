class UserDashboardController < ApplicationController
  def dashboard
    @payment_method = current_user.payment_methods.last
  end

  def purchases
    @purchases = current_user.books
  end
end
