class Musicpost < ActiveRecord::Base
    belongs_to :user
    has_many :mplikes
    has_many :mpliked_users, through: :mplikes, source: :user # 
    has_many :playlists
    has_many :playlisted_users, through: :playlists, source: :user
    has_many :mpcomments
    mount_uploader :image, MpImageUploader
    mount_uploader :music, MpMusicUploader
end
