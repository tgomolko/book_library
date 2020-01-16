require_dependency("create")

class CreateCharge
  include Interactor

  delegate :book, :current_user, :stripe_token, to: :context

  def call
    Charge.transaction do
     @charge = Stripe::Charges::Create.new(book.price.to_i, stripe_token).call

      context.charge = current_user.charges.create(build_charge_params)
      context.charge.paid!
    end

    rescue ActiveRecord::Rollback, Stripe::StripeError => error
      context.fail!(message: error.message)
  end

  def build_charge_params
    { book_id: book.id, stripe_id: @charge.id }
  end
end
