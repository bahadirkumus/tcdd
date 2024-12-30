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
  after_create_commit -> { broadcast_append_to "users" unless Rails.env.test? } # ActionCable

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
  has_one_attached :avatar

  has_many :active_follows, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_follows, source: :followed
  has_many :passive_follows, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
  has_many :followers, through: :passive_follows, source: :follower

  accepts_nested_attributes_for :profile

  has_many :folk_memberships
  has_many :folks, through: :folk_memberships

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

  # Follow a user
  def follow(other_user)
    active_follows.create(followed_id: other_user.id)
  end

  # Unfollow a user
  def unfollow(other_user)
    active_follows.find_by(followed_id: other_user.id).destroy
  end

  # Check if following a user
  def following?(other_user)
    following.include?(other_user)
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
