class CommentsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    before_action :authenticate_user! # 로그인 안된 사용자는 댓글을 작성하려고 하면 로그인 페이지로 가게된다.
    before_action :check_ownership!, only: [:destroy]
    
    def create
        new_comment = Comment.new(content: params[:content], post_id: params[:id_of_post], user_id: current_user.id)        
        new_comment.save
        render text: new_comment.content
        
        

        
    end
    
    def destroy
       
        @comment.destroy
        redirect_to :back
        
    end
    
    def edit
        
        
    end
    
    private
        def check_ownership!
            @comment = Comment.find_by(id: params[:id])
            redirect_to root_path if @comment.user.id != current_user.id 
            

        end
end
