class Message < ApplicationRecord
  # Callbacks
  before_create :confirm_chatuser
  after_create_commit :broadcast_message

  # Associations
  belongs_to :user
  belongs_to :chat

  # Validations
  validates :content, presence: true

  private

  def confirm_chatuser
    if self.chat.is_private
      is_chatuser = ChatUser.where(user_id: self.user.id, chat_id: self.chat.id).exists?
      throw(:abort) unless is_chatuser
    end
  end

  def broadcast_message
    # Broadcast to chat
    broadcast_append_to self.chat

    # Broadcast last message update to both users if private chat
    if self.chat.is_private
      other_user = self.chat.users.where.not(id: self.user_id).first
      sender = self.user

      # Broadcast to sender's view
      broadcast_update_to(
        "user_#{sender.id}_messages",
        target: "user_#{other_user.id}_last_message",
        partial: "users/last_message",
        locals: { 
          user: other_user,
          current_user: sender
        }
      )

      # Broadcast to receiver's view
      broadcast_update_to(
        "user_#{other_user.id}_messages",
        target: "user_#{sender.id}_last_message",
        partial: "users/last_message",
        locals: { 
          user: sender,
          current_user: other_user
        }
      )
    end
  end
end
