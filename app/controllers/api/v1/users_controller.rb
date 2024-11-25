module Api
  module V1
    class UsersController < Api::BaseController
      # Create User
      def create
        @user = User.new(user_params)
        @user.role = "user"
        @user.status = "active"

        if @user.save
          render json: {
            success: true,
            message: "User created successfully",
            data: user_response(@user)
          }, status: :created
        else
          render json: {
            success: false,
            errors: @user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      # Show user info
      def show
        @user = User.find_by(username: params[:username])
        if @user
          render json: {
            success: true,
            data: user_response(@user)
          }, status: :ok
        else
          render json: {
            success: false,
            errors: ["User not found"]
          }, status: :not_found
        end
      end

      # Update user info
      def update
        @user = User.find_by(username: params[:username])

        if @user == @current_user && @user.update(user_params)
          render json: {
            success: true,
            message: "User updated successfully",
            data: user_response(@user)
          }, status: :ok
        else
          render json: {
            success: false,
            errors: @current_user
          }, status: :unprocessable_entity
        end
      end

      # Check by username
      def check_username
        user = User.find_by(username: params[:username])
        render json: { exists: user.present? }
      end

      # Check by email
      def check_email
        user = User.find_by(email: params[:email])
        render json: { exists: user.present? }
      end

      private

      def user_params
        params.require(:user).permit(
          :name, :surname, :username, :email, :password, :password_confirmation,
          :birthday, :gender, :bio, :avatar_url, :location
        )
      end

      def user_response(user)
        {
          id: user.id,
          name: user.name,
          surname: user.surname,
          username: user.username,
          email: user.email,
          birthday: user.birthday,
          gender: user.gender,
          bio: user.bio,
          avatar_url: user.avatar_url,
          location: user.location,
          role: user.role,
          status: user.status
        }
      end
    end
  end
end