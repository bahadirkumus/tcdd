class Users::RegistrationsController < Devise::RegistrationsController
  layout 'welcome'
  before_action :configure_sign_up_params, only: [ :create ]
  before_action :configure_account_update_params, only: [ :update ]

  def new
    build_resource({})
    resource.build_profile
    respond_with resource
  end

  def create
    build_resource(sign_up_params)
    resource.save
    
    if resource.persisted?
      verification_code = resource.verification_codes.create!
      VerificationMailer.with(user: resource, verification_code: verification_code).verification_code_email.deliver_later
      
      if resource.active_for_authentication?
        set_flash_message! :notice, :signed_up
        sign_up(resource_name, resource)
        return redirect_to new_verification_path
      else
        set_flash_message! :notice, :"signed_up_but_#{resource.inactive_message}"
        expire_data_after_sign_in!
        return redirect_to new_verification_path
      end
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  protected

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username, :email, :password, :password_confirmation, profile_attributes: [ :name, :surname, :birthday, :gender ] ])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username, :email, :password, :password_confirmation, :current_password, profile_attributes: [ :name, :surname, :birthday, :gender, :bio, :avatar_url, :location, :status ] ])
  end

  def after_sign_up_path_for(resource)
    new_verification_path
  end
end
