class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  
  has_secure_password

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  before_save{ email.downcase! }
  before_save :create_remember_token

  validates :name, presence: true, length: { maximum: 50}
  validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true
  validates :password_confirmation, presence: true, length: {minimum: 6}

  has_many :microposts, dependent: :destroy

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.where("user_id = ?", id)
  end

  private 
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end

end
