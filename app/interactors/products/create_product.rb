require_dependency("create_stripe_product")

class CreateProduct
  include Interactor

  delegate :product_params, to: :context

  def call
    Product.transaction do
      @stripe_product = Stripe::Products::CreateStripeProduct.new(product_params).call

      context.product = Product.create!(build_product_params)
    end

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError => e
      rollback
      context.fail!(message: e.message)
  end

  private

  def rollback
    Stripe::Products::DestroyStripeProduct.new(@stripe_product.id).call if @stripe_product.id
  end

  def build_product_params
    product_params.merge(stripe_id: @stripe_product.id)
  end
end
