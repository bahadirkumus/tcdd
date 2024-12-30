class Profile < ApplicationRecord
  belongs_to :user
  has_one_attached :avatar

  # Callbacks
  before_validation :strip_and_capitalize_name_and_surname

  # Validations
  validates :name,
            presence: true,
            length: { in: 2..96 },
            format: { with: /\A[\p{L}\s]+\z/,
                      message: "only allows letters and spaces" }
  validates :surname,
            presence: true,
            length: { in: 2..96 },
            format: { with: /\A[\p{L}\s]+\z/,
                      message: "only allows letters and spaces" }
  validates :birthday, presence: true
  validates :gender, presence: true
  validates :bio, length: { maximum: 500 }, allow_blank: true
  validate :validate_avatar
  validates :location, length: { maximum: 100 }, allow_blank: true

  def full_name
    "#{name} #{surname}".strip
  end

  private

  def validate_avatar
    if avatar.attached?
      unless avatar.content_type.in?(%w[image/png image/jpg image/jpeg])
        errors.add(:avatar, "must be a PNG, JPG, or JPEG file.")
      end

      if avatar.byte_size > 5.megabytes
        errors.add(:avatar, "should be less than 5MB.")
      end
    end
  end

  def strip_and_capitalize_name_and_surname
    self.name = name.strip.gsub(/\s+/, " ").split.map(&:capitalize).join(" ") if name.present?
    self.surname = surname.strip.gsub(/\s+/, " ").split.map(&:capitalize).join(" ") if surname.present?
  end
end
