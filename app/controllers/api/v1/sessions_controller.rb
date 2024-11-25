module Api
  module V1
    class SessionsController < Api::BaseController

      # LogIn
      def create
        user = User.find_by(email: params[:session][:login].downcase) ||
          User.find_by(username: params[:session][:login].downcase)

        if user && user.authenticate(params[:session][:password])
          token = generate_token(user)
          render json: {
            success: true,
            message: "Login successful",
            data: {
              id: user.id,
              username: user.username,
              email: user.email,
              token: token
            }
          }, status: :ok
        else
          render json: {
            success: false,
            errors: ["Invalid email/username or password"]
          }, status: :unauthorized
        end
      end

      # Logout
      def destroy
        render json: { success: true, message: "Logout successful" }, status: :ok
      end

      private

      # JWT Generate Token
      def generate_token(user)
        payload = { user_id: user.id, exp: 24.hours.from_now.to_i }
        secret = Rails.application.credentials.jwt_secret_key
        JWT.encode(payload, secret, "HS256")
      end

      # Filter parameters
      def session_params
        params.require(:session).permit(:login, :password)
      end
    end
  end
end