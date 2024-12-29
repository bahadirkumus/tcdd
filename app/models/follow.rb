class Follow < ApplicationRecord
  # Associations
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # Validations
  validates :follower_id, uniqueness: { scope: :followed_id, message: "You are already following this user" }
  validate :follower_is_not_followed

  private

  def follower_is_not_followed
    errors.add(:follower_id, "You cannot follow yourself") if follower_id == followed_id
  end
end
