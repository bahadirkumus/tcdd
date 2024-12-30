class AddChatToFolks < ActiveRecord::Migration[7.2]
  def change
    add_reference :folks, :chat, foreign_key: true
  end
end