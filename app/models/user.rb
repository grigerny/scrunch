class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :provider, :uid, :oauth_token, :oauth_expires_at
  # attr_accessible :title, :body
  has_many :comments, :dependent => :destroy
  
  validates_presence_of :username
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  
  
  def self.from_omniauth(auth)
    where(auth.slice(:provider, :uid)).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.username = auth.info.nickname
      user.oauth_token = auth.credentials.token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    end
  end

  
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end
  
  def friends_count
    facebook.get_connection("me", "friends").size
  end
  
  def profile
    facebook.get_object("me")
  end
  
  def picture
    facebook.get_picture("uid")
  end
  
  def likes
     facebook.get_connection("me", "likes").size
   end
  
  def self.new_with_session(params, session)
    if session["devise.user_attributes"]
      new(session["devise.user_attributes"], without_protection: true) do |user|
        user.attributes = params
        user.valid?
      end
    else
      super
    end
  end
  
  def password_required?
    super && provider.blank?
  end
  
  def update_with_password(params, *options)
    if encrypted_password.blank?
      update_attributes(params, *options)
    else
      super
    end
end
end
