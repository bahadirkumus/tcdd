class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by(username: params[:username])
    if user.nil?
      flash[:alert] = "User not found."
      redirect_to root_path
    else
      current_user.follow(user)
      flash[:notice] = "Successfully followed!"
      redirect_to user_path(user.username)
    end
  end

  def destroy
    user = User.find_by(username: params[:username])
    if user.nil?
      flash[:alert] = "User not found."
      redirect_to root_path
    else
      current_user.unfollow(user)
      flash[:notice] = "Unfollowed successfully."
      redirect_to user_path(user.username)
    end
  end
end
