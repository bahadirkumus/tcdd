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
    if @focus_chat.is_private
      @user = @focus_chat.users.where.not(id: current_user.id).first
      @chat_name = get_name(@user, @current_user)
      @single_chat = Chat.where(name: @chat_name).first || Chat.create_private_chat([ @user, @current_user ], @chat_name)
      @messages = @single_chat.messages
    else
      @messages = @focus_chat.messages.order(created_at: :asc)
    end
    @message = Message.new
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
    @private_chats = current_user.chats.private_chats
  end

  def chat_params
    params.require(:chat).permit(:name, :is_private)
  end

  def get_name(user1, user2)
    users = [ user1, user2 ].sort_by(&:id)
    "private_#{users[0].id}_#{users[1].id}"
  end
end
