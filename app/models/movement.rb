class Movement < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  belongs_to :folk, optional: true # A movement can belong to a group

  def top_comments
    comments.order(created_at: :desc).limit(2)
  end
end
