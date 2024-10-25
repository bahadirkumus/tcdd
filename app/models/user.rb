class User < ApplicationRecord
  # Validations
  validates :name, presence: true, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)*\z/, message: "only allows letters and must not contain consecutive spaces" }
  validates :surname, presence: true, format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)*\z/, message: "only allows letters and must not contain consecutive spaces" }
  validates :username, presence: true, uniqueness: true, length: { in: 4..16 }, format: { with: /\A(?=.*[a-z])[a-z0-9_]+\z/, message: "only allows lowercase letters, numbers, underscores, and must contain at least one letter" }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
end