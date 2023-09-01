class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(text: comment_params[:text])
    @comment.user = current_user

    if @comment.save
      redirect_to user_post_path(@post.author, @post)
    else
      render 'posts/show'
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
