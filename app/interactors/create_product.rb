require_dependency("create_stripe_product")

class CreateProduct
  include Interactor

  delegate :product_params, to: :context

  def call
    Product.transaction do
      @stripe_product = Stripe::CreateStripeProduct.new(product_params).call

      product = Product.create(build_product_attrs)
      context.product = product
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      context.fail!(message: e.message)
  end

  private

  def build_product_attrs
    product_params[:product_type] = product_params.delete :type
    product_params[:stripe_id] = @stripe_product.id
    product_params
  end
end
