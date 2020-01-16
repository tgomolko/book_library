require_dependency("destroy")

class DestroyProduct
  include Interactor

  delegate :product, to: :context

  def call
    Product.transaction do
      Stripe::Products::Destroy.new(product.stripe_id).call

      product.destroy
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => error
      context.fail!(message: error.message)
  end

end
