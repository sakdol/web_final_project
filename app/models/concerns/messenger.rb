class Messenger < ActiveRecord::Base
    belongs_to :user
    
    validates :recever_email, presence: [ message: "존재하지 않는 유저입니다."]
end
