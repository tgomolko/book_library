class SubscriptionsController < ApplicationController
  before_action :load_plan, only: :new
  def new

  end

  def load_plan
    @plan = Plan.find(params[:plan_id])
  end
end
