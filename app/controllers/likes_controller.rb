class LikesController < ApplicationController
  def create
    @post = Post.find(params[:id])
    existing_like = @post.likes.find_by(user: current_user)

    if existing_like
      existing_like.destroy
      @post.decrement!(:likes_counter)
    else
      current_user.likes.create(post: @post)
    end

    redirect_to user_post_path(@post.author, @post)
  end
end
