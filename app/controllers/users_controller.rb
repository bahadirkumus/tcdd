class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
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
    @user = User.find_by(username: params[:username])
  end

  def update
    @user = User.find_by(username: params[:username])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(@user.username) # Redirect to the new username
    else
      render "edit"
    end
  end

  # Check if the username exists for ajax validation
  def check_username
    user = User.find_by(username: params[:username])
    render json: { exists: user.present? }
  end

  # Check if the email exists for ajax validation
  def check_email
    user = User.find_by(email: params[:email])
    render json: { exists: user.present? }
  end

  private

  def user_params
    params.require(:user).permit(:name, :surname, :username, :email, :password, :password_confirmation, :birthday,
                                 :gender)
  end
end
