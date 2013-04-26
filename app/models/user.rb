class User < ActiveRecord::Base
  has_secure_password
  attr_accessible :auth_token, :email, :password, :password_confirmation, 
                  :password_digest, :password_reset_at, :password_reset_token, 
                  :verification_token, :verified
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_presence_of :password, on: :create
  before_create { generate_token(:auth_token) }
  before_create { generate_token(:verification_token) }
  
  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end
  
  def verify!
    self.verified = true
    self.save
  end
  
  def verified?
    self.verified?
  end
  
  def deliver_verification_instructions(user)
    UserMailer.account_verification_instructions(self).deliver
  end
end





