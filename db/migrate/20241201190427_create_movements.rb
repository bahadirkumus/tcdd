class CreateMovements < ActiveRecord::Migration[7.2]
  def change
    create_table :movements do |t|
      t.string :body
      t.string :keywords

      t.timestamps
    end
  end
end
