class TeamcommentsController < ApplicationController

    skip_before_filter :verify_authenticity_token
    before_action :authenticate_user! # 로그인 안된 사용자는 댓글을 작성하려고 하면 로그인 페이지로 가게된다.
    before_action :check_teammember!
    before_action :check_ownership!, only: [:destroy]
    
    def create
        new_comment = Teamcomment.new(content: params[:content], team_id: params[:team_id], user_id: current_user.id)        
        new_comment.save
        redirect_to :back
        
        

        
    end
    
    def destroy
       
        @comment.destroy
        redirect_to :back
        
    end
    
    def edit
        
        
    end
    
    private
        def check_ownership!
            @comment = Teamcomment.find_by(id: params[:id])
            redirect_to root_path if @comment.user.id != current_user.id 
            

        end

        def check_teammember!
            

            team=Team.find_by(params[:team_id])    # 팀의 일원이거나 팀의 리더가 아니면 댓글을 올릴 수 없다.
            isfind = false
            team.teammembers.each do |member|
                if  member.member_id == current_user.id
                    isfind =true
                else
                  
                end
            end
            if team.leader_id == current_user.id
                isfind= true
            end 
            
            if isfind == true
                
                
            else
                redirect_to root_path
            end 
                
        end
end
