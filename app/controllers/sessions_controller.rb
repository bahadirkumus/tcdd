class SessionsController < ApplicationController
  def new
    @session = Session.new
  end

  def create
    user = User.find_by(email: params[:session][:login].downcase) || User.find_by(username: params[:session][:login].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user_path(user.username)
    else
      flash.now[:danger] = 'Invalid email/username or password'
      @session = Session.new(session_params)
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def session_params
    params.require(:session).permit(:login, :password, :remember_me)
  end
end
