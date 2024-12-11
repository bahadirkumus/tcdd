class Message < ApplicationRecord
  # Callbacks
  before_create :confirm_chatuser

  # ActionCable
  after_create_commit { broadcast_append_to self.chat }

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
end
