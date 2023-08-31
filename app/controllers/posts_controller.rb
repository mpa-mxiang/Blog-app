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
  
  def like
    @post = Post.find(params[:id])
    existing_like = @post.likes.find_by(user: current_user)

    if existing_like
      existing_like.destroy
      @post.decrement!(:likes_counter)
    else
      current_user.likes.create(post: @post)
      @post.increment!(:likes_counter)
    end

    redirect_to user_post_path(@post.author, @post)
  end
  
  def new
    @post = Post.new
  end
  private

  def post_params
    params.require(:post).permit(:title, :text)
  end

end
