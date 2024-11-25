class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def hello
    render html: "Hello, World"
  end
end

