class PostsController < ApplicationController
  def index
    @user = User.find(params[:user_id])
    @posts = @user.recent_posts.includes(:comments)
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
    @user = @post.author
  end
end
