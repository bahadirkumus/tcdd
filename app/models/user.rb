class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  # Virtual attribute for login with username or email
  attr_accessor :login

  # Scopes
  scope :all_except, ->(user) { where.not(id: user) }

  # Callbacks
  before_validation :downcase_username
  before_save { self.email = email.downcase }
  validate :password_complexity
  after_create_commit { broadcast_append_to "users" } # ActionCable

  # Validations
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
  validates :confirmation_token, uniqueness: true, allow_nil: true
  validates :status, length: { maximum: 100 }, allow_blank: true

  # Associations
  has_one  :profile, dependent: :destroy
  has_many :movements, dependent: :destroy
  has_many :vibes, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :shares, dependent: :destroy
  has_many :saves, dependent: :destroy
  has_many :chat_users
  has_many :chats, through: :chat_users
  has_many :messages, dependent: :destroy
  accepts_nested_attributes_for :profile

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

  # Password complexity requirements
  def password_complexity
    return if password.blank? || password =~ /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,96}$/

    errors.add :password, "Complexity requirement not met. Length should be 8-96 characters and include: 1 uppercase, 1 lowercase, 1 digit and 1 special character"
  end
end
