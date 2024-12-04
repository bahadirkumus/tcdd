module ApplicationHelper
  def is_user_logged_in?
    !session[:user_id].nil?
  end
end
