class AddAmountToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :amount, :integer
  end
end
