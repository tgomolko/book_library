class PlansController < ApplicationController
  before_action :load_plan, only: [:show, :edit, :update, :destroy]
  before_action :load_product, only: :create

  def index
    @plans = Plan.all
  end

  def new
    @products = Product.pluck(:name)
    @plan = Plan.new(product_id: params[:product_id] || nil)
  end

  def create
    result = CreatePlan.call(plan_params: plan_params, product_stripe_id: @product.stripe_id)

    if result.success?
      redirect_to result.plan, notice: "Plan was successfully created"
    else
      @plan = Plan.new(plan_params)
      flash.now.alert = result.message
      render :new
    end
  end

  def update
    #ActiveRecord::Base.transaction do
      @plan.update(plan_params)
      #UpdateStripePlan.new(@plan.stripe_id, plan_params).call
    #end

    redirect_to @plan, notice: 'Plan was successfully updated.'

    rescue ActiveRecord::Rollback, Stripe::StripeError, Exception => e
      flash.alert = e.message
      render :new
  end

  def destroy
    result = DestroyPlan.call(plan: @plan)

    if result.success?
      redirect_to plans_url, notice: 'Plan was successfully destroyed.'
    else
      redirect_to result.plan, alert: "#{result.message}"
    end
  end

  private

  def load_plan
    @plan = Plan.find(params[:id])
  end

  def plan_params
    params.require(:plan).permit(:nickname, :product_id, :currency, :interval, :stripe_id, :amount)
  end

  def load_product
    @product = Product.find(params[:plan][:product_id])
  end
end
