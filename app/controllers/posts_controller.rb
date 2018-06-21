class PostsController < ApplicationController
  impressionist
  before_action :authenticate_user! # 로그아웃이 된 상태에서는 list,create할 때 login페이지로 이동시킨다 .
  before_action :check_ownership, only: [:edit, :update,:destroy, :delete_files_from_s3]
  before_action :delete_files_from_s3, only: [:destroy,:update]
  def index
    if params[:query].nil?
      @posts = Post.paginate(:page => params[:page]).order('created_at desc') 
      @posts_count = current_user.posts.count
      @now = Time.now.in_time_zone("Seoul")
    elsif Post.where("musictype || title LIKE ?", "%#{params[:query]}%").nil?
      @error = "검색결과가 없습니다."
    else
      @posts = Post.where("musictype || title LIKE ?", "%#{params[:query]}%").order('created_at desc')
      @posts_count = current_user.musicposts.count #posts? musicposts?
      @now = Time.now.in_time_zone("Seoul")
    end
  end
 
  def show
    @post = Post.find(params[:id])
    @Team = Team.find_by(post_id: params[:id])
    @now = Time.now.in_time_zone("Seoul")  
  end
  
  def new
    
  end
  
  def create
    
    
    new_post= Post.new(user_id: current_user.id,title: params[:title],musictype: params[:musictype],content: params[:content], requirement: params[:requirement], image: params[:image],music: params[:music])
    
    if new_post.save 
      id_of_post=new_post.id
      new_team= Team.new(leader_id: current_user.id,post_id: id_of_post)
      if new_team.save
        redirect_to "/posts"
      else
        render text: new_team.errors.messages
      end
    else
      render text: new_post.errors.messages
    end

      
    
  end
  
  def edit
  
  end
  
  
  
  def update # S3에서도 수정가능하게 해야하는 것 같은데 아직 구현 못함..
    @post.music = params[:music]
    @post.image = params[:image]
    @post.title = params[:title]
    @post.musictype = params[:musictype]
    @post.requirement =params[:requirement]
    @post.content = params[:content]
    
    if @post.save
      redirect_to "/posts"
    else
      render text: @post.errors.messages
      #render :edit # edit 페이지가 또 다시 뜸
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
    
    @post.comments.each do |comment|
      comment.destroy
    end
    
    team=Team.find_by(post_id: @post.id) # Team, Teammember도 다 삭제.
    team.teammembers.each do |member|
      member.destroy
    end
    team.destroy
    
    @post.destroy
    
    redirect_to "/posts"
  end
  
  
  private
  
  def check_ownership
      @post =Post.find_by(id: params[:id]) # 질문 : 여기서는 delete method라서 params[:id]이렇게 받을 수 있는건가?
    redirect_to root_path if @post.user_id != current_user.id
    
  end
end