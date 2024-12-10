class Message < ApplicationRecord
  # ActionCable
  after_create_commit { broadcast_append_to self.chat }

  # Associations
  belongs_to :user
  belongs_to :chat

  # Validations
  validates :content, presence: true
end
