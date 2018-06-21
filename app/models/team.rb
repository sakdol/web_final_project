class Team < ActiveRecord::Base
    
    has_many :teammembers
    has_many :team
    has_many :teamcomments
end
