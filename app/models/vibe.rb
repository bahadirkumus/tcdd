class Vibe < ApplicationRecord
  belongs_to :user
  has_one_attached :video
  validates :caption, presence: true, length: { maximum: 300 }
  validates :video, presence: true
  validate :video_format_and_duration
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user
  has_many :comments, dependent: :destroy
  private

  def video_format_and_duration
    return unless video.attached?
    if !video.blob.content_type.in?(%w[video/mp4 video/mov])
      errors.add(:video, "sadece MP4 veya MOV formatında olabilir.")
    end
    if video.metadata[:duration].to_i > 30
      errors.add(:video, "30 saniyeden uzun olamaz.")
    end
  end
end