class Chat < ApplicationRecord
  # Scopes
  scope :public_chats, -> { where(is_private: false) }

  # Validations
  validates_uniqueness_of :name

  # Associations
  after_create_commit { broadcast_append_to "chats" }
end
