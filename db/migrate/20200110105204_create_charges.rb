class CreateCharges < ActiveRecord::Migration[5.2]
  def change
    create_table :charges do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.integer :status, default: 0
      t.string :stripe_id

      t.timestamps
    end
  end
end
