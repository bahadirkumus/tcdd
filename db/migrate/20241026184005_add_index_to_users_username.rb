class AddIndexToUsersUsername < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, :id if index_exists?(:users, :id)
    add_index :users, :username, unique: true
  end
end
