class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_product_policy
  before_action :load_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.includes(:plans)
  end

  def new
    @product = Product.new
  end

  def create
    result = CreateProduct.call(product_params: product_params)

    if result.success?
      redirect_to result.product, notice: "Product was successfully created"
    else
      @product = Product.new(product_params)
      flash.now.alert = result.message
      render :new
    end
  end

  def update
    if @product.update(product_params)
      redirect_to @product, notice: 'Product was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    result = DestroyProduct.call(product: @product)

    if result.success?
      redirect_to products_url, notice: 'Product was successfully destroyed.'
    else
      redirect_to result.product, alert: "#{result.message}"
    end
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
