class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:following, :followers]

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user != current_user
      current_user.follow(@user)
    end
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = User.find_by(username: params[:username])
    if @user && @user != current_user
      current_user.unfollow(@user)
    end
    redirect_back(fallback_location: root_path)
  end

  def following
    @following = @user.following
    @title = "#{@user.username} kullanıcısının takip ettikleri"
    render 'following'
  end

  def followers
    @following = @user.followers
    @title = "#{@user.username} kullanıcısının takipçileri"
    render 'following'
  end

  private

  def set_user
    @user = User.find_by!(username: params[:username])
  end
end
