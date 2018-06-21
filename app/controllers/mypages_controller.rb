class MypagesController < ApplicationController
    
    def showmyposts # 내가 올린 게시물들 보기
        
    end
    
    def mymessages # 나의 쪽지함
        
    end
    
    def mycomments # 내가 단 댓글 보기 
        
    end
    
    def mylikedposts # 내가 좋아요한 게시물들 보기
    
    end
    
    def following #내가 팔로우 하는 사람들의 게시글 보기
        
    end
    
    def profile # 마이페이지의 프로필
        
    end
    
    def myteam # 팀원신청내역
        @my_applications = Teammember.where(member_id: params[:user_id]) # 내가 지원한 현황
        @my_team = Team.where(leader_id: params[:user_id]) # 내가 리더인 팀
        @my_grantedapps = Teammember.where(member_id: params[:user_id],waiting: false,granted: true) # 내가 팀원 지원해서 승인된 팀
           # 내가 리더인 팀의 지원 현황
    end
    
    def user_profile
        @u_profile = User.find(params[:user_id])
    end
    
end
