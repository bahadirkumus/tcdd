class AddVibeToComments < ActiveRecord::Migration[7.2]
  def change
    add_reference :comments, :vibe, foreign_key: true
  end
end
