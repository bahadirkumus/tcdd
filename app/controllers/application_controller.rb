class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_in_path_for(resource)
    user_path(resource.username)
  end

  def after_sign_up_path_for(resource)
    user_path(resource.username)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :surname, :username, :birthday, :gender ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :surname, :username, :birthday, :gender, :bio, :avatar_url, :location ])
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :login, :password, :remember_me ])
  end
end