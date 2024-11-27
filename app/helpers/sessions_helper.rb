module SessionsHelper
  # Logs in the given user.
  def log_in(user)
    session[:username] = user.username
  end

  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:username] = {
      value: user.username,
      httponly: true,
      secure: Rails.env.production?
    }
    cookies.permanent[:remember_token] = {
      value: user.remember_token,
      httponly: true,
      secure: Rails.env.production?
    }
  end

  # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:username)
    cookies.delete(:remember_token)
  end

  # Logs out the current user.
  def log_out
    forget(current_user)
    session.delete(:username)
    @current_user = nil
  end

  # Returns the current logged-in user (if any).
  def current_user
    if (username = session[:username])
      @current_user ||= User.find_by(username: username)
    elsif (username = cookies.signed[:username])
      user = User.find_by(username: username)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_user.nil?
  end
end
