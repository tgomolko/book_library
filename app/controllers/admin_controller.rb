class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin_dashboard_access

  def dashboard

  end

  private

  def ensure_admin_dashboard_access
    redirect_to root_path, notice: "Access disable, only for admins" unless current_user.admin?
  end
end
