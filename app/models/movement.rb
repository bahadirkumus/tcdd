class Movement < ApplicationRecord
  validates :body, presence: true, length: { minimum: 5, maximum: 1000 }
  has_many_attached :images
  belongs_to :user

  before_create :randomize_id
  private
  def randomize_id
    begin
      self.id = SecureRandom.random_number(1_000_000_000)
    end while User.where(id: self.id).exists?
  end
end
