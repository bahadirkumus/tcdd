class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :Users do |t|
      t.string :name
      t.string :surname
      t.string :username
      t.string :email

      t.timestamps
    end
  end
end
