class Movement < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader

  has_many :likes, dependent: :destroy
end
