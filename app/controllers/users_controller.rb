class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :edit_username, :update_username, :edit_email, :update_email, :edit_password, :update_password, :update_bio, :update_location ]
  before_action :logged_in_user, only: [ :edit, :update, :edit_username, :update_username, :edit_email, :update_email, :edit_password, :update_password, :update_bio, :update_location ]

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
    # @user is set by the set_user before_action
  end

  def edit
    # @user is set by the set_user before_action
  end

  def update
    if @user.authenticate(params[:user][:password])
      redirect_to edit_user_path(@user.username)
    else
      flash.now[:alert] = "Incorrect password."
      render :edit
    end
  end

  def edit_username
    # @user is set by the set_user before_action
  end

  def update_username
    if @user.authenticate(params[:user][:password])
      if @user.update(username_params)
        flash[:success] = "Username was successfully updated."
        redirect_to user_path(@user.username)
      else
        flash.now[:alert] = "Failed to update username. Please check the username."
        render :edit_username
      end
    else
      flash.now[:alert] = "Incorrect password."
      render :edit_username
    end
  end

  def edit_email
    # @user is set by the set_user before_action
  end

  def update_email
    if @user.authenticate(params[:user][:password])
      if @user.update(email_params)
        flash[:success] = "Email was successfully updated."
        redirect_to user_path(@user.username)
      else
        flash.now[:alert] = "Failed to update email. Please check the email address."
        render :edit_email
      end
    else
      flash.now[:alert] = "Incorrect password."
      render :edit_email
    end
  end

  def edit_password
    # @user is set by the set_user before_action
  end

  def update_password
    if @user.authenticate(params[:user][:current_password])
      if @user.update(password_params)
        flash[:success] = "Password was successfully updated."
        redirect_to user_path(@user.username)
      else
        render :edit_password
      end
    else
      flash.now[:alert] = "Incorrect current password."
      render :edit_password
    end
  end

  def update_bio
    if @user.update(bio_params)
      respond_to do |format|
        format.html { redirect_to user_path(@user.username), notice: "Bio was successfully updated." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_path(@user.username), alert: "Failed to update bio." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_location
    if @user.update(location_params)
      respond_to do |format|
        format.html { redirect_to user_path(@user.username), notice: "Location was successfully updated." }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to user_path(@user.username), alert: "Failed to update location." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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

  def logged_in_user
    unless logged_in?
      flash[:alert] = "Please log in."
      redirect_to login_path
    end
  end

  def signup_params
    params.require(:user).permit(:name, :surname, :username, :email, :password, :password_confirmation, :birthday, :gender)
  end

  def username_params
    params.require(:user).permit(:username)
  end

  def email_params
    params.require(:user).permit(:email)
  end

  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def bio_params
    params.require(:user).permit(:bio)
  end

  def location_params
    params.require(:user).permit(:location)
  end
end
