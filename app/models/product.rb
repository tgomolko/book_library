class Product < ApplicationRecord
  PRODUCT_TYPES = ["service", "good"]

  validates :name, presence: true
  has_many :plans
  has_many :subscriptions
  has_many :users, through: :subscriptions
end
