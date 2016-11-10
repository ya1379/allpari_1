class User < ActiveRecord::Base
  has_secure_password
  before_save { self.email = email.downcase }
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :username, presence: true, uniqueness: true, length: {in: 2..20}
  validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
  validates :password, length: { minimum: 6 }
  #validates_length_of :password, in: 6..20, :on => :create
  
end
