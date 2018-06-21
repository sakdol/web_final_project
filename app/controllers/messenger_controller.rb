class MessengerController < ApplicationController
    
    #쪽지 페이지 table 크기 고정좀 하고 긴 제목은 .. 처리 
    #인덱스부분 페이지네이션
    before_action :authenticate_user! # 로그아웃이 된 상태에서는 list,create할 때 login페이지로 이동시킨다 .
    def index
    @messenger = Receivemessenger.where(recever_email: current_user.email)
    @messenger2 = Messenger.where(sender_email: current_user.email)
    @posts = Messenger.paginate(:page => params[:page], :per_page => 9)
    end
      
    def write
        @sender = params[:sender]
        @receive = params[:receive]
    end
      
    def create

        if User.find_by(email: params[:recever_email]).nil?
            flash[:notice] = "존재하지 않는 유저입니다."
            redirect_to :back
            
        else
            new_messenger = Messenger.new
            new_messenger.title = params[:message_title]
            new_messenger.content = params[:message_content]
            new_messenger.recever_email = params[:recever_email]
            new_messenger.sender_email = params[:sender_email]
            new_messenger.user_id = current_user.id
            new_messenger.save
            
            new_receive_messenger = Receivemessenger.new
            new_receive_messenger.title = params[:message_title]
            new_receive_messenger.content = params[:message_content]
            new_receive_messenger.recever_email = params[:recever_email]
            new_receive_messenger.sender_email = params[:sender_email]
            new_receive_messenger.user_id = User.find_by(email: params[:recever_email]).id
            new_receive_messenger.save
            
            redirect_to "/messenger/index"
        end
    
    end
      
    def destroy1 #보낸메세지 삭제
    @one_messenger = Messenger.find(params[:messenger_id])
    @one_messenger.destroy
    
    redirect_to "/messenger/index"
    end
    
    def destroy2 #받은 메세지 삭제
    @one_messenger = Receivemessenger.find(params[:receive_id])
    @one_messenger.destroy
    
    redirect_to "/messenger/index"
    end

    def view #보낸메세지 읽기
        @view_messenger = Messenger.find(params[:messenger_id])
    end
    
    def view2 #받은메세지 읽기
        @view_messenger = Receivemessenger.find(params[:receive_id])
    end
end
