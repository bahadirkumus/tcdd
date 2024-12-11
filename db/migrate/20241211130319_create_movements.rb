class CreateMovements < ActiveRecord::Migration[7.2]
  def change
    create_table :movements do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.string :image

      t.timestamps
    end
  end
end
