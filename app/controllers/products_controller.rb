class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_product_policy
  before_action :load_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    CreateStripeProduct.new(@product).call

    if @product.save
      redirect_to @product, notice: 'Product was successfully created.'
    else
      render :new
    end

    rescue Stripe::StripeError => e
      flash.alert = e.message
  end

  def update
    if @product.update(product_params)
      #UpdateStripeProduct.new(@product).call
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    ActiveRecord::Base.transaction do
      @product.destroy
      DestroyStripeProduct.new(@product.stripe_id).call
    end

    redirect_to products_url, notice: 'Product was successfully destroyed.'

    rescue Stripe::StripeError => e
      flash.alert = e.message
  end

  private

  def load_product
    @product = Product.find(params[:id])
  end


  def product_params
    params.require(:product).permit(:name, :product_type, :stripe_id)
  end

  def check_product_policy
    redirect_to root_path, alert: "Access disable, only for admins" unless current_user.admin?
  end
end
