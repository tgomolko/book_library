class User < ApplicationRecord
  enum role: [:user, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :subscriptions
  has_many :products, through: :subscriptions
  has_many :payment_methods, dependent: :destroy
  has_many :books, dependent: :destroy

  def subscribed?(product)
    products.include?(product)
  end
end
