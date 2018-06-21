class TeamsController < ApplicationController
    
    before_action :check_teammember! , only: [:showallcomments]
    def create
        
    end
    
    def destroy
        
    end
    
    def close
        team = Team.find(params[:team_id])
        team.ongoing = false
        if team.save 
            redirect_to root_path
        else
            render "mypages/error"
        end
    end
    
    def showallcomments
       @now = Time.now.in_time_zone("Seoul")
       @teamcomments = Teamcomment.where(team_id: params[:team_id])
       
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
