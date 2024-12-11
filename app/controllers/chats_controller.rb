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
      @chats = @user.chats
      @chat = find_or_create_chat
      @messages = @chat.messages
      @message = Message.new
      @message.user = current_user
      @other_user = User.find(@other_user_id) if @other_user_id
      # @chat_name = get_name(@user, @current_user)
      # @single_chat = Chat.where(name: @chat_name).first || Chat.create_private_chat([ @user, @current_user ], @chat_name)
      # @messages = @single_chat.messages
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

  def find_or_create_chat
    # Get the current user's ID
    @user_id = current_user.id.to_i

    # Check if another user ID is provided in the params
    @other_user_id = params[:other_user_id].to_i if params[:other_user_id].present?

    @other_user = User.find(@other_user_id) if @other_user_id

    if @other_user_id
      # Find an existing chat where both users are participants
      chat = Chat.joins(:chat_users)
        .where(chats: { name: generate_chat_name(@user_id, @other_user_id) })
        .where(chat_users: { user_id: [ @user_id, @other_user_id ] })
        .group("chats.id")
        .having("COUNT(DISTINCT chat_users.user_id) = 2").first

      # If no existing chat is found, create a new chat
      chat ||= Chat.create(name: generate_chat_name(@user_id, @other_user_id))

      # Create chat users for both participants
      create_chat_user(chat, @user_id)
      create_chat_user(chat, @other_user_id)

    else
      # If no other user ID is provided, find the chat based on the provided chat ID
      chat = Chat.find(params[:id])
    end
    chat
  end

  def generate_chat_name(user_id, other_user_id)
    [ user_id, other_user_id ].sort.join("&")
  end

  # Define a method to create a chat user record for a given user in a chat
  def create_chat_user(chat, user_id)
    # Find or create a chat user record with the specified user ID
    chat.chat_users.find_or_create_by(user_id: user_id)
  end

  # def get_name(user1, user2)
  #   users = [ user1, user2 ].sort_by(&:id)
  #   "private_#{users[0].id}_#{users[1].id}"
  # end
end
