class Vibe < ApplicationRecord
  belongs_to :user
  has_one_attached :video
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  validates :caption, presence: true, length: { maximum: 300 }
  validates :video, presence: true
  validate :video_format_and_duration

  private

  # Video formatını ve süresini kontrol et
  def video_format_and_duration
    return unless video.attached?

    if !video.blob.content_type.in?(%w[video/mp4 video/mov])
      errors.add(:video, "sadece MP4 veya MOV formatında olabilir.")
    end

    # Active Storage analizini beklemek gerekir
    if video.metadata[:duration].to_i > 30
      errors.add(:video, "30 saniyeden uzun olamaz.")
    end
  end
end
