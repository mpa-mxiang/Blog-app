class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all # Fetch all users from the database
  end

  def show
    @user = User.find(params[:id]) # Find a user by ID
    @posts = @user.posts.includes(:comments)
  end
end
