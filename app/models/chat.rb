class Chat < ApplicationRecord
  # ActionCable
  after_create_commit { broadcast_if_public }

  # Scopes
  scope :public_chats, -> { where(is_private: false) }
  scope :private_chats, -> { where(is_private: true) }

  # Validations
  validates :name, presence: true, uniqueness: true
  validate :validate_name_format

  # Associations
  has_many :chat_users
  has_many :users, through: :chat_users
  has_many :messages, dependent: :destroy

  before_validation :strip_name

  private

  def broadcast_if_public
    broadcast_append_to "chats" unless self.is_private
  end

  def strip_name
    self.name = name.strip.gsub(/\s+/, " ") if name.present?
  end

  def validate_name_format
    # Validation for private chat names
    if is_private
      errors.add(:name, "cannot have consecutive spaces") if name =~ /\s{2,}/
      errors.add(:name, "cannot consist only of spaces") if name.strip.empty?
    else
      unless name =~ /\A[a-zA-Z0-9_ ]+\z/
        errors.add(:name, "only allows letters, numbers, underscores, and spaces")
      end
      errors.add(:name, "cannot have consecutive spaces") if name =~ /\s{2,}/
      errors.add(:name, "cannot consist only of spaces") if name.strip.empty?
    end
  end
end
