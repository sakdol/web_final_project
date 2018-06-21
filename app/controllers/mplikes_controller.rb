class MplikesController < ApplicationController
    before_action :authenticate_user!
    
    def mplike_toggle # 좋아요 클릭하거나 취소했을때의 action /// toggle: 있으면 없애고, 없으면 있게.
        mplike = Mplike.find_by(user_id: current_user.id,musicpost_id: params[:musicpost_id])
        if mplike.nil?
           newlike=Mplike.new(user_id: current_user.id, musicpost_id: params[:musicpost_id])
           newlike.save
           
        else
            mplike.destroy
        end
        
        post= Musicpost.find(params[:musicpost_id])
            # redirect_to :back # 버튼을 클릭했던 페이지로 돌아간다.
            render text: post.mplikes.count
    end
end

