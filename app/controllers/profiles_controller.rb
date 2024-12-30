class ProfilesController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    render template: "profiles/show"
  end

  def edit
    render template: "profiles/edit"
  end

  def update
    ActiveRecord::Base.transaction do
      if @user.profile.update(profile_params) && handle_avatar_update
        respond_to do |format|
          format.html do
            flash[:success] = "Profil güncellendi"
            redirect_to user_path(@user.username)
          end
          format.turbo_stream
        end
      else
        render template: "profiles/edit"
      end
    end
  end

  private

  def handle_avatar_update
    return true unless params[:user] && params[:user][:avatar]
    
    @user.avatar.purge if @user.avatar.attached?
    @user.avatar.attach(params[:user][:avatar])
  end

  def set_user
    @user = User.find_by(username: params[:username])
    if @user.nil?
      flash[:alert] = "Kullanıcı bulunamadı."
      redirect_to root_path
    end
  end

  def correct_user
    @user = User.find_by(username: params[:username])
    redirect_to(root_url) unless current_user == @user
  end

  def profile_params
    params.require(:profile).permit(:name, :surname, :birthday, :gender, :bio, :location, :status)
  end
end
