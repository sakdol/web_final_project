class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  ##### Team Making posts #################        
  has_many :posts
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post # 유저가 like했던 posts를 likes를 토대로, post인 것들만 찾아온다.
  has_many :comments
  
  ##### Music post ########
  has_many :musicposts
  has_many :mplikes
  has_many :mpliked_posts, through: :mplikes, source: :musicpost
  has_many :mpcomments
  has_many :playlists
  has_many :playlisted_posts, through: :playlists, source: :musicpost
  
  #### messenger ########
  has_many :receivemessengers
  has_many :messengers
  
  
  
  ########## 현재 로그인한 사람을 follow하는 사람을 찾기 위한 db ############
  has_many :follower_relations, foreign_key: "followed_id", class_name: "Follow" # 현재 로그인한 사람의 id를 외래키로 해서 followed_id 값이 현재 로그인한 사람의 id 와 같으면  
  has_many :followers, through: :follower_relations, source: :follower   # 추출해 온다.
  ###########################################################################
  ########## 현재 로그인한 사람이 follow하는 사람을 찾기 위한 db ############
  has_many :following_relations, foreign_key: "follower_id", class_name: "Follow"
  has_many :followings, through: :following_relations, source: :followed
  ###########################################################################
  
  mount_uploader :avatar, AvatarUploader
  
  def is_like?(post)
    Like.find_by(user_id: self.id, post_id: post.id).present? # find_by 결과값이 있으면 true
  end
  
  def is_mplike?(post)
    Mplike.find_by(user_id: self.id, musicpost_id: post.id).present? 
  end
  
  def is_playlist?(post)
    Playlist.find_by(user_id: self.id, musicpost_id: post.id).present?  
  end
  
  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name   # assuming the user model has a name
      user.image = auth.info.image # assuming the user model has an image
      # If you are using confirmable and the provider(s) you use validate emails, 
      # uncomment the line below to skip the confirmation emails.
      # user.skip_confirmation!
    end
    	
  end
  
  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end

  
end
