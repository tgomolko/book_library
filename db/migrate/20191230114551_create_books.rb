class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author
      t.references :user, foreign_key: true
      t.decimal :price

      t.timestamps
    end
  end
end
