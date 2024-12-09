class Chat < ApplicationRecord
  validates_uniqueness_of :name
  scope :public_chats, -> { where(is_private: false) }
end
