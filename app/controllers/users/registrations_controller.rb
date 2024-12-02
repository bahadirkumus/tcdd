class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]

  # POST /resource
  def create
    build_resource(sign_up_params)

    # Set default role
    resource.role = "user"

    resource.save
    yield resource if block_given?
    if resource.persisted?
      resource.confirm # Automatically confirm the user
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  # Permit additional parameters for sign up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :surname, :username, :email, :birthday, :gender, :password, :password_confirmation ])
  end

  # Override the path used after sign up
  def after_sign_up_path_for(resource)
    user_path(resource.username) # Redirect to the user's profile page
  end
end
