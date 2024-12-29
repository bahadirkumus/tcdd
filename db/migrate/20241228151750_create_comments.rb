class CreateComments < ActiveRecord::Migration[7.2]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.references :movement, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.integer :parent_comment_id, index: true
      t.timestamps
    end
  end
end
