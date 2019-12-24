class Product < ApplicationRecord
  PRODUCT_TYPES = ["service", "good"]
  has_many :plans
end
