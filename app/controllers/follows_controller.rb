class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find(params[:followed_id])
    current_user.following << user
    redirect_to user, notice: "Takip edildi!"
  end

  def destroy
    user = User.find(params[:id])
    current_user.following.delete(user)
    redirect_to user, notice: "Takipten çıkıldı!"
  end
end
