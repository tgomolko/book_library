class RemoveUserFromBook < ActiveRecord::Migration[5.2]
  def change
    remove_reference :books, :user, index: true, foreign_key: true
  end
end
