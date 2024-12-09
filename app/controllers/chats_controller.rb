class ChatsController < ApplicationController
  before_action :authenticate_user!
  def index
    @current_user = current_user
    @chats = Chat.public_chats
    @users = User.all_except(@current_user)
  end
end
