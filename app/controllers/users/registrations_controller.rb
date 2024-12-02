class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

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

  # GET /resource/edit
  def edit
    @user = current_user
    render template: "users/edit"
  end

  # PUT /resource
  def update
    @user = current_user
    if @user.update(account_update_params)
      flash[:success] = "Profile updated"
      redirect_to user_path(@user.username)
    else
      render template: "users/edit"
    end
  end

  protected

  # Permit additional parameters for sign up
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :name, :surname, :username, :email, :birthday, :gender, :password, :password_confirmation ])
  end

  # Permit additional parameters for account update
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :name, :surname, :username, :email, :birthday, :gender, :bio, :avatar_url, :location, :password, :password_confirmation, :current_password ])
  end

  # The path used after sign up for inactive accounts.
  def after_update_path_for(resource)
    user_path(resource.username)
  end
end
