class VerificationsController < ApplicationController
  layout 'welcome'
  before_action :authenticate_user!
  before_action :require_unverified_user

  def new
    @verification_code = current_user.verification_codes.last
  end

  def create
    @verification_code = current_user.verification_codes.last
    
    if @verification_code&.valid_code?(params[:code])
      current_user.update(confirmed_at: Time.current)
      redirect_to user_path(current_user.username), notice: 'Your email has been successfully verified!'
    else
      flash.now[:alert] = 'Invalid verification code. Please try again.'
      render :new
    end
  end

  private

  def require_unverified_user
    redirect_to root_path if current_user.confirmed?
  end
end 