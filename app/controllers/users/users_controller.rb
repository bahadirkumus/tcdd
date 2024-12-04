module Users
  class UsersController < ApplicationController
    before_action :set_user, only: [ :show, :edit, :update ]
    before_action :authenticate_user!, only: [ :edit, :update ]
    before_action :correct_user, only: [ :edit, :update ]

    def show
      # @user is set by the set_user before_action
      render template: "users/show"
    end

    def edit
      # @user is set by the set_user before_action
      render template: "users/edit"
    end

    def update
      if user_params[:password].blank?
        user_params.delete(:password)
        user_params.delete(:password_confirmation)
      end

      if @user.update(user_params)
        flash[:success] = "User settings updated"
        redirect_to user_path(@user.username)
      else
        render template: "users/edit"
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
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
  end
end
