class User < ActiveRecord::Base
  has_secure_password
  before_create :create_remember_token
  before_save { self.email = email.downcase }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: true, length: {in: 2..20}
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, length: { minimum: 6 }
  #validates_length_of :password, in: 6..20, :on => :create
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
