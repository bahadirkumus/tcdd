class AddAdvancedFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :birthday, :date
    add_column :users, :role, :string
    add_column :users, :gender, :string
    add_column :users, :followers_count, :integer, default: 0
    add_column :users, :following_count, :integer, default: 0
    add_column :users, :bio, :string
    add_column :users, :avatar_url, :string
    add_column :users, :location, :string
    add_column :users, :status, :string
    add_column :users, :last_seen_at, :timestamp
    add_column :users, :confirmed_at, :timestamp
    add_column :users, :confirmation_token, :string
    add_column :users, :preferences, :jsonb, default: {}
    add_index :users, :confirmation_token, unique: true
  end
end
