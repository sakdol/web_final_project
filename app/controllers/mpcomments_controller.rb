class MpcommentsController < ApplicationController
    skip_before_filter :verify_authenticity_token
    before_action :authenticate_user! # 로그인 안된 사용자는 댓글을 작성하려고 하면 로그인 페이지로 가게된다.
    before_action :check_ownership!, only: [:destroy]
    
    def create
        #Comment -> mpcomment로
        new_mpcomment = Mpcomment.new(content: params[:content], musicpost_id: params[:id_of_post],user_id: current_user.id)        
        new_mpcomment.save
        render text: new_mpcomment.content
        
                
        
    end
    
    def destroy
       
        @mpcomment.destroy
        redirect_to :back
    end
    
    def edit
        
        
    end
    
    private
        def check_ownership!
            @mpcomment = Mpcomment.find_by(id: params[:id])
            redirect_to root_path if @mpcomment.user.id != current_user.id 
        end
end
