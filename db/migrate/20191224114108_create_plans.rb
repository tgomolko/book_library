class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.string :title
      t.references :product, foreign_key: true
      t.string :currency
      t.string :interval
      t.string :stripe_id

      t.timestamps
    end
  end
end
