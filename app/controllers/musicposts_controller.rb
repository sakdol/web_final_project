class MusicpostsController < ApplicationController
  before_action :authenticate_user! # 로그아웃이 된 상태에서는 list,create할 때 login페이지로 이동시킨다 .
  before_action :check_ownership, only: [:edit, :update,:destroy, :delete_files_from_s3]
  before_action :delete_files_from_s3, only: [:destroy,:update]
  def index
    if params[:query].nil?
      @posts = Musicpost.all.order('created_at desc')
      @posts_count = current_user.musicposts.count #posts? musicposts?
      @now = Time.now.in_time_zone("Seoul")
    else
      @posts = Musicpost.where("musictype || title LIKE ?", "%#{params[:query]}%").order('created_at desc')
      @posts_count = current_user.musicposts.count #posts? musicposts?
      @now = Time.now.in_time_zone("Seoul")
    end
  end
  
  def result
    @posts = Musicpost.where("user.name LIKE ?", "%#{params[:query]}%")
    @posts_count = current_user.musicposts.count #posts? musicposts?
    @now = Time.now.in_time_zone("Seoul")
  end
  
  def show
    @post = Musicpost.find(params[:id])
   @now = Time.now.in_time_zone("Seoul")
  end 
  
  def new
    
  end
  
  def create
    
    
    new_musicpost= Musicpost.new(user_id: current_user.id,title: params[:title],musictype: params[:musictype],content: params[:content],image: params[:image],music: params[:music])
    if new_musicpost.save
      redirect_to root_path
    else
      redirect_to new_post_path
    end
  end
  
  def edit
  
  end
  
  
  
  def update # S3에서도 수정가능하게 해야하는 것 같은데 아직 구현 못함..
    @post.music = params[:music]
    @post.image = params[:image]
    @post.title = params[:title]
    @post.musictype = params[:musictype]
    @post.content = params[:content]
    
    if @post.save
      redirect_to root_path
    else
      render :edit # edit 페이지가 또 다시 뜸
    end
  end
  
  
  def delete_files_from_s3
    s3=AWS::S3.new
#    S3_BUCKET= s3.buckets['newwaves']
    key= @post.image.url.split('amazonaws.com/')[1]
    musickey = @post.music.url.split('amazonaws.com/')[1]
    S3_BUCKET.object(key).delete
    S3_BUCKET.object(musickey).delete
    return true
    rescue => e
      return true
    
    
  end
    
  def destroy  # S3에서도 수정가능하게 해야하는 것 같은데 아직 구현 못함..
    @post.mpcomments.each do |comment|
      comment.destroy
    end
    @post.destroy
    
    redirect_to root_path
  end
  
  
  private
  
  def check_ownership
      @post =Musicpost.find_by(id: params[:id]) # 질문 : 여기서는 delete method라서 params[:id]이렇게 받을 수 있는건가?
    redirect_to root_path if @post.user_id != current_user.id
    
  end
end
