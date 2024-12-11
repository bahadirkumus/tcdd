class Chat < ApplicationRecord
  # ActionCable
  after_create_commit { broadcast_if_public }

  # Scopes
  scope :public_chats, -> { where(is_private: false) }
  scope :private_chats, -> { where(is_private: true) }

  # Validations
  validates :name, presence: true, uniqueness: true
  # Associations
  has_many :messages
  has_many :chat_users

  private

  def broadcast_if_public
    broadcast_append_to "chats" unless self.is_private
  end

  def self.create_private_chat(users, chat_name)
    focus_chat = Chat.create(name: chat_name, is_private: true)
    users.each do |user|
      ChatUser.create(user_id: user.id, chat_id: focus_chat.id)
    end
    focus_chat
  end
end
