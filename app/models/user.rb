class User < ApplicationRecord
  # Callbacks
  before_validation :downcase_username
  before_save :capitalize_name_and_surname
  before_save { self.email = email.downcase }

  # Validations
  validates :name, presence: true, length: { in: 2..96 }, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)*\z/, message: "only allows letters and must not contain consecutive spaces" }
  validates :surname, presence: true, length: { in: 2..96 }, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)*\z/, message: "only allows letters and must not contain consecutive spaces" }
  validates :username, presence: true, uniqueness: true, length: { in: 4..16 }, format: { with: /\A(?=.*[a-z])[a-z0-9_]+\z/, message: "only allows lowercase letters, numbers, underscores, and must contain at least one letter" }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }

  has_secure_password
  validates :password, presence: true, length: { minimum: 8, maximum: 72 }, format: { with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,72}\z/, message: "must include at least one lowercase letter, one uppercase letter, one digit, and one special character" }, allow_nil: true # allow_nil: true allows for password to be nil when updating user

  private

  def downcase_username
    self.username = username.downcase if username.present?
  end

  def capitalize_name_and_surname
    self.name = name.split.map(&:capitalize).join(' ') if name.present?
    self.surname = surname.split.map(&:capitalize).join(' ') if surname.present?
  end
end