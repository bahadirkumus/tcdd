class ChangeMovementIdToAllowNullInComments < ActiveRecord::Migration[7.2]
  def change
    change_column_null :comments, :movement_id, true
  end
end
