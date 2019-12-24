class UpdateStripeProduct
  attr_reader :product

  def initialize(product)
    @product = product
  end

  def call
    Stripe::Product.update(
      product.stripe_id, { name: product.name, type: product.product_type }
    )
  end
end
