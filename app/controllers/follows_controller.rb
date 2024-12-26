class FollowsController < ApplicationController
  before_action :authenticate_user!

  def create
    user = User.find_by(username: params[:username])
    if user.nil?
      flash[:alert] = "Kullanıcı bulunamadı."
      redirect_to root_path
    else
      current_user.follow(user)
      flash[:notice] = "Başarıyla takip ettiniz!"
      redirect_to user
    end
  end

  def destroy
    user = User.find_by(username: params[:username])
    if user.nil?
      flash[:alert] = "Kullanıcı bulunamadı."
      redirect_to root_path
    else
      current_user.unfollow(user)
      flash[:notice] = "Takipten çıkıldı."
      redirect_to user
    end
  end
end
