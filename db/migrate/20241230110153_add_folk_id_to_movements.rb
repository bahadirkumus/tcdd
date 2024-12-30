class AddFolkIdToMovements < ActiveRecord::Migration[7.2]
  def change
    add_reference :movements, :folk, null: false, foreign_key: true
  end
end
