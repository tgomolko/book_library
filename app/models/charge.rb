class Charge < ApplicationRecord
  belongs_to :user
  belongs_to :book

  enum status: [:unpaid, :paid]
end
