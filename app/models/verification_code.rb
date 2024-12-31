class VerificationCode < ApplicationRecord
  belongs_to :user
  
  validates :code, presence: true, length: { is: 6 }
  validates :expires_at, presence: true
  
  before_validation :generate_code
  before_validation :set_expiration
  
  def expired?
    Time.current > expires_at
  end
  
  def valid_code?(input_code)
    code == input_code && !expired?
  end
  
  private
  
  def generate_code
    self.code ||= SecureRandom.random_number(100000..999999).to_s
  end
  
  def set_expiration
    self.expires_at ||= 10.minutes.from_now
  end
end 