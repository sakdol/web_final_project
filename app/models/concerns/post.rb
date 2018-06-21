class Post < ActiveRecord::Base
    belongs_to :user
    has_many :likes
    has_many :liked_users, through: :likes, source: :user # 
    has_many :comments
    mount_uploader :image, PostImageUploader
    mount_uploader :music, PostMusicUploader
    
    self.per_page = 10
    is_impressionable
    
    validates :title, :requirement, :content, presence: { message: "제목을 입력하세요"}
end
