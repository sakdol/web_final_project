class LikesController < ApplicationController
    
    before_action :authenticate_user!
    
    def like_toggle # 좋아요 클릭하거나 취소했을때의 action /// toggle: 있으면 없애고, 없으면 있게.
        like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
        
        if like.nil?
           Like.create(user_id: current_user.id,post_id: params[:post_id]) 
        else
            like.destroy
        end
        
        post= Post.find(params[:post_id])
            # redirect_to :back # 버튼을 클릭했던 페이지로 돌아간다.
            render text: post.likes.count
    end
end
