class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render "new"
    end
  end

  def check_username
    user = User.find_by(username: params[:username])
    render json: { exists: user.present? }
  end

  def check_email
    user = User.find_by(email: params[:email])
    render json: { exists: user.present? }
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

  private

  def user_params
    params.require(:user).permit(:name, :surname, :username, :email, :password, :password_confirmation)
  end
end
