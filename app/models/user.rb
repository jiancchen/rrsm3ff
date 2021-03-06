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
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship",
    dependent: :destroy
  has_many :followers, through: :reverse_relationships, source: :follower

  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Micropost.from_users_followed_by(self)
  end

  def following?(other_user)
    relationships.find_by_followed_id(other_user.id)
  end

  def follow!(other_user)
    relationships.create!(followed_id: other_user.id)
  end

  def unfollow!(other_user)
    relationships.find_by_followed_id(other_user.id).destroy
  end

  private 
  	def create_remember_token
  		self.remember_token = SecureRandom.urlsafe_base64
  	end

end
