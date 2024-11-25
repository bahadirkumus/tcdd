module Api
  class BaseController < ActionController::API
    def authorize_request
      header = request.headers['Authorization']
      puts "Authorization Header: #{header}" # Gelen başlığı yazdır

      token = header.split(' ').last if header
      puts "Extracted Token: #{token}" # Çıkarılan token

      begin
        decoded = JWT.decode(token, Rails.application.credentials.jwt_secret_key, true, { algorithm: 'HS256' })
        puts "Decoded Token: #{decoded.inspect}" # Decode edilen token
        @current_user = User.find_by(id: decoded[0]['user_id'])
        puts "Current User: #{@current_user.inspect}" # Kullanıcıyı yazdır
      rescue ActiveRecord::RecordNotFound
        render json: { success: false, errors: ["User not found"] }, status: :unauthorized
      rescue JWT::DecodeError
        render json: { success: false, errors: ["Invalid token"] }, status: :unauthorized
      rescue JWT::ExpiredSignature
        render json: { success: false, errors: ["Token has expired"] }, status: :unauthorized
      end
    end
  end
end