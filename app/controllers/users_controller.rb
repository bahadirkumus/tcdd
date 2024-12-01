class UsersController < ApplicationController
  before_action :set_user, only: [ :edit, :update ]
  before_action :logged_in?, only: [ :edit, :update ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(signup_params)
    @user.role = "user" # Set the default role to 'user'
    @user.status = "active" # Set the default status to 'active'
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Soon Network, #{@user.name}!"
      redirect_to user_path(@user.username)
    else
      render "new"
    end
  end

  def show
    @user = User.find_by(username: params[:username])
  end

  def edit
  end

  def update
    if @user.update(update_params)
      flash[:success] = "Profile was successfully updated."
      redirect_to edit_user_path(@user.username)
    else
      render :edit
    end
  end

  private

  def set_user
    @user = if params[:username] =~ /^\d+$/
              User.find_by(id: params[:username])
    else
              User.find_by(username: params[:username])
    end
    if @user.nil?
      flash[:alert] = "User not found."
      redirect_to root_path
    end
  end

  def signup_params
    params.require(:user).permit(:name, :surname, :username, :email, :password, :password_confirmation, :birthday, :gender)
  end

  def update_params
    params.require(:user).permit(:name, :surname, :username, :email, :password, :password_confirmation, :birthday, :gender, :bio, :avatar_url, :location, :status)
  end
end
