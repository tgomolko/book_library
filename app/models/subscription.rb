class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :product
  belongs_to :plan
end
