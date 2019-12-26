class User < ApplicationRecord
  enum role: [:user, :admin]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :subscriptions
  has_many :products, through: :subscriptions
end