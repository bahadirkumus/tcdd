class Chat < ApplicationRecord
  # ActionCable
  after_create_commit { broadcast_append_to "chats" }

  # Scopes
  scope :public_chats, -> { where(is_private: false) }

  # Validations
  validates :name, presence: true, uniqueness: true
  # Associations
  has_many :messages
end
