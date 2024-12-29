class Profile < ApplicationRecord
  belongs_to :user

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
  validates :avatar_url,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true
  validates :location, length: { maximum: 100 }, allow_blank: true

  private

  def strip_and_capitalize_name_and_surname
    self.name = name.strip.gsub(/\s+/, " ").split.map(&:capitalize).join(" ") if name.present?
    self.surname = surname.strip.gsub(/\s+/, " ").split.map(&:capitalize).join(" ") if surname.present?
  end
end
