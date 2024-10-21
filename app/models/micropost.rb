class Micropost < ApplicationRecord
  belongs_to :user
  # validates :content, length: { maximum: 140 , minimum: 10, message: "Content must be between 10 and 140 characters" }
end