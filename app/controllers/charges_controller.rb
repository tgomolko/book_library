class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_book, only: [:new, :create]
  before_action :load_charge, only: :success


  def new
    respond_to do |format|
      format.js
    end
  end

  def create
    result = CreateCharge.call(book: @book, stripe_token: params[:stripeToken], current_user: current_user)

    if result.success?
      @charge = result.charge
     # redirect_to @book, notice: "Paid!"
      redirect_to generate_bill_path(id: result.charge, format: :pdf)
     # redirect_to success_payment_path(id: result.charge.id), format: 'js'
    else
      flash.now.alert = result.message
      render :new
    end
  end

  def success
    respond_to do |format|
      format.js
    end
  end

  private

  def load_book
    @book = Book.find(params[:book_id])
  end

  def load_charge
    @charge = Charge.find(params[:id])
  end
end
