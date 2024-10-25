class AddPasswordToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :password, :string
  end
end
