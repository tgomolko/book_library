require_dependency("create")

class CreateProduct
  include Interactor

  delegate :product_params, to: :context

  def call
    @stripe_product = Stripe::Products::Create.new(product_params).call

    context.product = Product.create!(build_product_params)

    rescue ActiveRecord::ActiveRecordError, Stripe::StripeError => error
      rollback if error.kind_of?(ActiveRecord::ActiveRecordError)
      context.fail!(message: error.message)
  end

  private

  def rollback
    Stripe::Products::Destroy.new(@stripe_product.id).call if @stripe_product.id
  end

  def build_product_params
    product_params.merge(stripe_id: @stripe_product.id)
  end
end

