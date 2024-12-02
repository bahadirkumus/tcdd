module Users
  class UsersController < ApplicationController
    before_action :set_user, only: [ :show, :edit, :update, :edit_username, :update_username, :edit_email, :update_email, :edit_password, :update_password, :update_bio, :update_location ]
    before_action :authenticate_user!, only: [ :edit, :update, :edit_username, :update_username, :edit_email, :update_email, :edit_password, :update_password, :update_bio, :update_location ]
    before_action :correct_user, only: [ :edit, :update, :edit_username, :update_username, :edit_email, :update_email, :edit_password, :update_password, :update_bio, :update_location ]

    def show
      # @user is set by the set_user before_action
      render template: "users/show"
    end

    def edit
      # @user is set by the set_user before_action
      render template: "users/edit"
    end

    def update
      if @user.update(user_params)
        flash[:success] = "Profile updated"
        redirect_to @user
      else
        render template: "users/edit"
      end
    end

    def edit_username
      # @user is set by the set_user before_action
      render template: "users/edit_username"
    end

    def update_username
      if @user.update_with_password(username_params)
        flash[:success] = "Username was successfully updated."
        redirect_to user_path(@user.username)
      else
        flash.now[:alert] = "Failed to update username. Please check the username."
        render template: "users/edit_username"
      end
    end

    def edit_email
      # @user is set by the set_user before_action
      render template: "users/edit_email"
    end

    def update_email
      if @user.update_with_password(email_params)
        flash[:success] = "Email was successfully updated."
        redirect_to user_path(@user.username)
      else
        flash.now[:alert] = "Failed to update email. Please check the email address."
        render template: "users/edit_email"
      end
    end

    def edit_password
      # @user is set by the set_user before_action
      render template: "users/edit_password"
    end

    def update_password
      if @user.update_with_password(password_params)
        flash[:success] = "Password was successfully updated."
        redirect_to user_path(@user.username)
      else
        flash.now[:alert] = "Failed to update password. Please check the password."
        render template: "users/edit_password"
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

    def correct_user
      @user = User.find_by(username: params[:username])
      redirect_to(root_url) unless current_user == @user
    end

    def user_params
      params.require(:user).permit(:name, :surname, :username, :email, :password, :password_confirmation, :bio, :avatar_url, :location)
    end

    def username_params
      params.require(:user).permit(:username, :current_password)
    end

    def email_params
      params.require(:user).permit(:email, :current_password)
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation, :current_password)
    end

    def bio_params
      params.require(:user).permit(:bio)
    end

    def location_params
      params.require(:user).permit(:location)
    end
  end
end
