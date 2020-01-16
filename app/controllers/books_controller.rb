class BooksController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :check_book_policy, except: [:index, :show]
  before_action :load_book, only: [:show, :edit, :update, :destroy]

  def index
    @books = Book.all.order("created_at ASC")
    @plans = Plan.all.order(:amount)
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      redirect_to @book, notice: 'Book was successfully created.'
    else
      render :new
    end
  end

  def update
    if @book.update(book_params)
      redirect_to @book, notice: 'Book was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @book.destroy
    redirect_to books_url, notice: 'Book was successfully destroyed.'
  end

  private

  def load_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:book).permit(:title, :description, :author, :price, :image, :document)
  end

  def check_book_policy
    redirect_to root_path, alert: "Access disable only for admins" unless current_user.admin?
  end
end
