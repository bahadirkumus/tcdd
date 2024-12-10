class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :chat_data, only: [ :index, :create, :show ]

  def index
    @chat = Chat.new
  end

  def new
    @chat = Chat.new
  end

  def create
    @chat = Chat.new(chat_params)
    if @chat.save
      @chat = Chat.new
      render :index
    else
      render :new
    end
  end

  def show
    @focus_chat = Chat.find(params[:id])
    @message = Message.new
    @messages = @focus_chat.messages.order(created_at: :asc)
    @chat = Chat.new
    render :index
  end

  def update
    # @chat = Chat.find(params[:id])
    # if @chat.update(chat_params)
    # redirect_to @chat
    # else
    # render 'edit'
    # end
  end

  def destroy
    # chat = Chat.find(params[:id])
    # chat.destroy
    # redirect_to chats_path
  end

  private

  def chat_data
    @current_user = current_user
    @chats = Chat.public_chats
    @users = User.all_except(@current_user)
  end

  def chat_params
    params.require(:chat).permit(:name)
  end
end
