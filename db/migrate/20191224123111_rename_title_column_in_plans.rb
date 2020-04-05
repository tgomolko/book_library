class RenameTitleColumnInPlans < ActiveRecord::Migration[5.2]
  def change
    rename_column :plans, :title, :nickname
  end
end
