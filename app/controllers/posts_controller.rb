class PostsController < ApplicationController
    def index
        @posts = Post.all # Fetch all posts from the database
      end
    def show
        @post = Post.find(params[:id]) # Find a post by ID
    end
      
end
