class PostsController < ApplicationController
  def index
    @user = current_user
    @posts = @user.recent_posts.includes(:comments)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @user = @post.author
    @comment = Comment.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to user_posts_path(current_user), notice: 'Post was successfully created.'
    else
      @posts = current_user.recent_posts.includes(:comments) # Add this line to update @posts
      render 'new'
    end
  end
  
  
  def new
    @post = Post.new
  end
  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

end
