class CreatePaymentMethods < ActiveRecord::Migration[5.2]
  def change
    create_table :payment_methods do |t|
      t.references :user, foreign_key: true
      t.string :stripe_id
      t.string :last4
      t.integer :exp_month
      t.integer :exp_year
      t.string :brand

      t.timestamps
    end
  end
end
