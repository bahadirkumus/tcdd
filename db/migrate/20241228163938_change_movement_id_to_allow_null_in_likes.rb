class ChangeMovementIdToAllowNullInLikes < ActiveRecord::Migration[7.2]
  def change
    change_column_null :likes, :movement_id, true
  end
end
