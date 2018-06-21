class IndexController < ApplicationController
    def index
        @tmposts = Post.order("RANDOM()").limit(12)
        @mposts= Musicpost.order("RANDOM()").limit(12)
        @tm1 = @tmposts.sample(4)
        @tm2 = (@tmposts-@tm1).sample(4)
        @tm3 = (@tmposts-@tm1-@tm2).sample(4)
        @mp1 = @mposts.sample(4)
        @mp2 = (@mposts-@mp1).sample(4)
        @mp3 = (@mposts-@mp1-@mp2).sample(4)
      
        
        
    end
end
