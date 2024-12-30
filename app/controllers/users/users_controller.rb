module Users
  class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :follow_user]
    before_action :authenticate_user!, only: [:edit, :update, :follow_user]
    before_action :correct_user, only: [:edit, :update]

    def index
      if params[:query].present?
        @users = User.where('username LIKE ?', "%#{params[:query]}%")
      else
        @users = []
      end

      respond_to do |format|
        format.html # Normal HTML yanıt
        format.js   # AJAX yanıt
      end
    end

    def show
      @movements = @user.movements.order(created_at: :desc)
      @total_posts = @user.movements.count
      render template: "users/show"
    end

    def edit
      render template: "users/edit"
    end

    def update
      if user_params[:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end

      if user_params[:username].blank?
        flash.now[:alert] = "Username can't be blank"
        render template: "users/edit" and return
      end

      if @user.update(user_params)
        bypass_sign_in(@user)
        flash[:success] = "User settings updated"
        redirect_to user_path(@user.username)
      else
        render template: "users/edit"
      end
    end

    def follow_user
      @user = User.find_by(username: params[:username])
      if @user
        current_user.follow(@user)
        flash[:notice] = "Başarıyla takip ettiniz!"
        redirect_to @user.username
      else
        flash[:alert] = "Kullanıcı bulunamadı."
        redirect_to root_path
      end
    end

    def unfollow_user
      @user = User.find_by(username: params[:username])
      if @user
        current_user.unfollow(@user)
        flash[:notice] = "Başarıyla takipten çıktınız!"
        redirect_to @user
      else
        flash[:alert] = "Kullanıcı bulunamadı."
        redirect_to root_path
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
