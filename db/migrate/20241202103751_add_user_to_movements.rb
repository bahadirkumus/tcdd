class AddUserToMovements < ActiveRecord::Migration[7.2]
  def change
    add_reference :movements, :user, null: false, foreign_key: true
  end
end
