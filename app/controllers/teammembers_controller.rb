class TeammembersController < ApplicationController
    
    def create
    
        new_teammember=Teammember.new(member_id: params[:user_id],team_id: params[:team_id])
        if new_teammember.save
           redirect_to root_path 
        else
            render text: new_teammember.errors.messages
        end
    end

    def destroy

        new_teammember=Teammember.find(params[:id])
        new_teammember.destroy
        
        redirect_to root_path        
    end
    
    def grant
        teammember=Teammember.find_by(team_id: params[:team_id],member_id: params[:teammember_id])
        teammember.waiting = false # waiting 값을 false로,
        teammember.granted = true# granted 값을 true로
        if teammember.save
            redirect_to root_path
        else 
            render "mypages/error" 
        end
    end
    
    def reject
        teammember=Teammember.find_by(team_id: params[:team_id],member_id: params[:teammember_id])
        teammember.waiting = false # waiting 값을 false로,
        teammember.granted = false # granted 값을 false로
        teammember.save
        if teammember.save
            redirect_to root_path
        else 
            render "mypages/error" 
        end        
    end
end
