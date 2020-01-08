require_dependency("destroy_stripe_product")

class DestroyProduct
  include Interactor

  delegate :product, to: :context

  def call
    Product.transaction do
      Stripe::DestroyStripeProduct.new(product.stripe_id).call
      product.destroy
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      context.fail!(message: e.message)
  end

end
