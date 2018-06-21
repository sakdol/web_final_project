class PlaylistsController < ApplicationController
    
    before_action :authenticate_user!
    
    def index
        
    end
    
    def playlist_toggle # 
        playlist = Playlist.find_by(user_id: current_user.id, musicpost_id: params[:musicpost_id])
        
        if playlist.nil?
           Playlist.create(user_id: current_user.id,musicpost_id: params[:musicpost_id]) 
        else
            playlist.destroy
        end
        
        
             redirect_to :back # 버튼을 클릭했던 페이지로 돌아간다.
            
    end    
end
