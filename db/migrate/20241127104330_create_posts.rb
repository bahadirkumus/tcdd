class CreatePosts < ActiveRecord::Migration[7.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :body
      t.string :post_type, null: false
      t.string :photo
      t.references :user, null: false, foreign_key: true
      t.timestamps
    end
  end
end
