class AddVibeIdToLikes < ActiveRecord::Migration[7.2]
  def change
    add_reference :likes, :vibe, foreign_key: true
  end
end
