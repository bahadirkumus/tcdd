class Users::SessionsController < Devise::SessionsController
  before_action :configure_sign_in_params, only: [ :create ]

  protected

  # Permit the login parameter along with password and remember_me
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:sign_in, keys: [ :login, :password, :remember_me ])
  end
end
