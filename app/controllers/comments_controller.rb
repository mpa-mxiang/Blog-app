class CommentsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(text: comment_params[:text]) # Use the correct parameter name
    @comment.user = current_user
  
    if @comment.save
      @post.increment!(:comments_counter)
      redirect_to user_post_path(@post.author, @post), notice: 'Comment was successfully created.'
    else
      render 'posts/show'
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:text)
  end
    
end
