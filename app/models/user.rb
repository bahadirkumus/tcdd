class User < ApplicationRecord
  attr_accessor :login
  # Devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :trackable

  # Callbacks
  before_validation :downcase_username
  before_validation :strip_and_capitalize_name_and_surname
  before_save { self.email = email.downcase }
  validate :password_complexity

  # Validations
  validates :name,
            presence: true,
            length: { in: 2..96 },
            format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)*\z/,
                      message: "only allows letters and must not contain consecutive spaces" }
  validates :surname,
            presence: true,
            length: { in: 2..96 },
            format: { with: /\A[a-zA-Z]+(?: [a-zA-Z]+)*\z/,
                      message: "only allows letters and must not contain consecutive spaces" }
  validates :username,
            presence: true,
            uniqueness: true,
            length: { in: 4..16 },
            format: { with: /\A(?=.*[a-z])[a-z0-9_]+\z/,
                      message: "only allows lowercase letters, numbers, underscores, and must contain at least one letter" }
  validates :email,
            presence: true,
            uniqueness: true,
            format: { with: URI::MailTo::EMAIL_REGEXP,
                      message: "must be a valid email address" }

  validates :birthday, presence: true
  validates :role, presence: true
  validates :gender, presence: true
  validates :bio, length: { maximum: 500 }, allow_blank: true
  validates :avatar_url,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]), message: "must be a valid URL" }, allow_blank: true
  validates :location, length: { maximum: 100 }, allow_blank: true
  validates :status, length: { maximum: 100 }, allow_blank: true
  validates :confirmation_token, uniqueness: true, allow_nil: true

  # Associations
  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :saves, dependent: :destroy


  # Override Devise method to allow login with username or email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login.include?("@")
      where(conditions.to_h).where([ "lower(email) = :value", { value: login.downcase } ]).first
    else
      where(conditions.to_h).where([ "lower(username) = :value", { value: login.downcase } ]).first
    end
  end


  private

  def downcase_username
    self.username = username.downcase if username.present?
  end

  def strip_and_capitalize_name_and_surname
    self.name = name.strip.gsub(/\s+/, " ").split.map(&:capitalize).join(" ") if name.present?
    self.surname = surname.strip.gsub(/\s+/, " ").split.map(&:capitalize).join(" ") if surname.present?
  end

  # Password complexity requirements
  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,96}$/

    errors.add :password, "Complexity requirement not met. Length should be 8-96 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character"
  end
end
