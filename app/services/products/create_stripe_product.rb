class CreateStripeProduct
  attr_reader :product

  def initialize(product)
    @product = product
  end

  def call
    stripe_product = Stripe::Product.create({ name: product.name, type: product.product_type })
    product.stripe_id = stripe_product.id
  end
end
