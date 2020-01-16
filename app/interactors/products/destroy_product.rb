require_dependency("destroy")

class DestroyProduct
  include Interactor

  delegate :product, to: :context

  def call
    Product.transaction do
      Stripe::Products::Destroy.new(product.stripe_id).call

      product.destroy
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => e
      context.fail!(message: e.message)
  end

end
