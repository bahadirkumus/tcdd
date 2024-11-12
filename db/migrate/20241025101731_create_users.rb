class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :surname
      t.string :username
      t.string :email
      t.string :password_digest
      t.date :birthday
      t.string :role
      t.string :gender
      t.integer :followers_count, default: 0
      t.integer :following_count, default: 0
      t.string :bio
      t.string :avatar_url
      t.string :location
      t.string :status
      t.timestamp :last_seen_at
      t.timestamp :confirmed_at
      t.string :confirmation_token
      t.jsonb :preferences, default: {}

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :confirmation_token, unique: true
  end
end
