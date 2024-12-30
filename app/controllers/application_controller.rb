class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_user_session

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :surname, :username, :birthday, :gender ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :surname, :username, :birthday, :gender, :bio, :avatar_url, :location ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :login, :password, :remember_me ])
  end

  def set_user_session
    session[:user_id] = current_user.id if user_signed_in?
  end

  # After sign in redirected to user
  def after_sign_in_path_for(resource)
    user_path(resource.username)
  end

  # Log out and trigger the animation
  def after_sign_out_path_for(resource_or_scope)
    root_path + "?trigger_animation=true"
  end
end
