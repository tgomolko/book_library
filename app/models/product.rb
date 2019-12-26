class Product < ApplicationRecord
  PRODUCT_TYPES = ["service", "good"]
  has_many :plans
  has_many :subscriptions
  has_many :users, through: :subscriptions
end
