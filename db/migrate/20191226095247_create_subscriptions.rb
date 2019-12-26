class CreateSubscriptions < ActiveRecord::Migration[5.2]
  def change
    create_table :subscriptions do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.string :stripe_id
      t.integer :plan_id

      t.timestamps
    end
  end
end
