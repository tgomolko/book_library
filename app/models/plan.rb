class Plan < ApplicationRecord
  CURRENCIES = ["usd", "eur", "rus"]
  INTERVALS = ["month", "week", "year"]
  belongs_to :product
end
