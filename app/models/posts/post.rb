module Posts
  class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :comments, dependent: :destroy
    has_many :shares, dependent: :destroy
    has_many :saves, dependent: :destroy

    has_one_attached :photo

    validates :post_type, presence: true, inclusion: { in: %w[text_post photo_post] }
    validates :body, presence: true, if: -> { post_type == "text_post" }
    validate :photo_presence_for_photo_post

    def photo_presence_for_photo_post
      if post_type == "photo_post"
        if !photo.attached?
          errors.add(:photo, "must be attached for photo posts.")
        elsif !photo.content_type.in?(%w[image/png image/jpg image/jpeg])
          errors.add(:photo, "must be a PNG, JPG, or JPEG file.")
        end
      end
    end
  end
end