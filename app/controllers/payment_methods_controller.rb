class PaymentMethodsController  < ApplicationController
  before_action :authenticate_user!
  before_action :load_payment_method, only: [:show, :destroy]

  def new_card
    #redirect_to root_path, notice: "You have already had payment method" and return unless current_user.payment_methods.any?
  end

  def cards
    @cards = current_user.payment_methods
  end

  def create_card
    result = CreateCard.call(card_params: card_params, current_user: current_user, card_token: params[:stripeToken])

    if result.success?
      redirect_to card_path(result.payment_method), notice: 'You have successfully added card'
    else
      @payment_method = PaymentMethod.new(card_params)
      flash.now.alert = result.message
      render :new_card
    end
  end

  def destroy
    result = DestroyCard.call(payment_method: @payment_method, customer_id: current_user.stripe_id)

    if result.success?
      redirect_to cards_path, notice: 'You have successfully remove card'
    else
      redirect_to card_path(result.payment_method), alert: "#{result.message}"
    end
  end

  private

  def load_payment_method
    @payment_method = PaymentMethod.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:last4, :exp_month, :stripe_id, :exp_year, :brand, :user_id)
  end
end
