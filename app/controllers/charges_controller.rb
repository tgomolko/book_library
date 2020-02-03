class ChargesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_book, only: [:new, :create]

  def create
    result = CreateCharge.call(book: @book, stripe_token: params[:stripeToken], current_user: current_user)

    if result.success?
      redirect_to @book, notice: "Paid!"
     # redirect_to generate_bill_path(id: result.charge, format: :pdf)
    else
      flash.now.alert = result.message
      render :new
    end
  end

  private

  def load_book
    @book = Book.find(params[:book_id])
  end
end
