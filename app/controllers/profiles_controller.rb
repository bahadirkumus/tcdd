class ProfilesController < ApplicationController
  before_action :set_user, only: [ :edit, :update ]
  before_action :authenticate_user!, only: [ :edit, :update ]
  before_action :correct_user, only: [ :edit, :update ]

  def edit
    # @user is set by the set_user before_action
    render template: "profiles/edit"
  end

  def update
    if @user.profile.update(profile_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(@user.username)
    else
      render template: "profiles/edit"
    end
  end

  private

  def set_user
    @user = User.find_by(username: params[:username])
    if @user.nil?
      flash[:alert] = "User not found."
      redirect_to root_path
    end
  end

  def correct_user
    @user = User.find_by(username: params[:username])
    redirect_to(root_url) unless current_user == @user
  end

  def profile_params
    params.require(:profile).permit(:name, :surname, :birthday, :gender, :bio, :avatar_url, :location, :status)
  end
end
