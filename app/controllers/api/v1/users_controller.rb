module Api
  module V1
    class UsersController < ApplicationController
      protect_from_forgery with: :null_session

      def create
        @user = User.new(user_params)
        @user.role = "user"
        @user.status = "active"

        if @user.save
          render json: {
            success: true,
            message: "User created successfully",
            data: {
              id: @user.id
            }
          }, status: :created
        else
          render json: {
            success: false,
            errors: @user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(
          :name, :surname, :username, :email, :password, :password_confirmation,
          :birthday, :gender, :bio, :avatar_url, :location
        )
      end
    end
  end
end