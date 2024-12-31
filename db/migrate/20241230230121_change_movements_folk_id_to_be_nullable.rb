class ChangeMovementsFolkIdToBeNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :movements, :folk_id, true
  end
end
