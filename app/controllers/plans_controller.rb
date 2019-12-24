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
    @plan = Plan.new(plan_params)

    CreateStripePlan.new(@plan, plan_params, @product.stripe_id).call

    if @plan.save
      redirect_to @plan, notice: 'Plan was successfully created.'
    else
      render :new
    end

    rescue Stripe::StripeError => e
      flash.alert = e.message
  end

  def update
    ActiveRecord::Base.transaction do
      @plan.update(plan_params)
      #UpdateStripePlan.new(@plan.stripe_id, plan_params).call
    end

    redirect_to @plan, notice: 'Plan was successfully updated.'

    rescue ActiveRecord::Rollback, Stripe::StripeError, Exception => e
      flash.alert = e.message
      render :new
  end

  def destroy
    ActiveRecord::Base.transaction do
      @plan.destroy
      DestroyStripePlan.new(@plan.stripe_id).call
    end

    redirect_to plans_url, notice: 'Plan was successfully destroyed.'

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      flash.alert = e.message
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
