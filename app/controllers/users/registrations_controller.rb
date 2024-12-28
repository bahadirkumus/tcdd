class Users::RegistrationsController < Devise::RegistrationsController
  layout 'welcome'
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  def new
    # Build a profile object for the user
    build_resource({})
    resource.build_profile
    respond_with resource
  end

  protected

  # Permit additional parameters for sign up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :email, :password, :password_confirmation, profile_attributes: [ :name, :surname, :birthday, :gender ] ])
  end

  # Permit additional parameters for account update
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :email, :password, :password_confirmation, :current_password, profile_attributes: [ :name, :surname, :birthday, :gender, :bio, :avatar_url, :location, :status ] ])
  end

  # After sign up redirected to user
  def after_sign_up_path_for(resource)
    user_path(resource.username)
  end

end
