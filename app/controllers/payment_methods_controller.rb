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
    @payment_method = current_user.payment_methods.build(card_params)

    ActiveRecord::Base.transaction do
      CreateStripeCustomer.new(current_user, params[:stripeToken]).call
      @payment_method.save
    end

    redirect_to show_card_path(@payment_method), notice: 'You have successfully added card'

    rescue Stripe::StripeError => e
      flash.alert = e.message
      render :create_card
  end

  def destroy
    ActiveRecord::Base.transaction do
      DeattachPaymentMethod.new(current_user).call
      @payment_method.destroy
    end

    redirect_to subscriptions_path, notice: 'You have successfully remove card'

    rescue Stripe::StripeError => e
      flash.alert = e.message
      render :show
  end

  private

  def load_payment_method
    @payment_method = PaymentMethod.find(params[:id])
  end

  def card_params
    params.require(:card).permit(:last4, :exp_month, :stripe_id, :exp_year, :brand, :user_id)
  end
end
