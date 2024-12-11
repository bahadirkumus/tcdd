class ChatsController < ApplicationController
  before_action :authenticate_user!
  before_action :chat_data, only: [ :index, :create, :show, :private_chat ]

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
      flash[:alert] = "Private chats cannot be accessed through this route."
      redirect_to chats_path and return
    else
      @messages = @focus_chat.messages.order(created_at: :asc)
      @message = Message.new
      render :index
    end
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

  def private_chat
    if params[:other_user_id].present?
      @other_user_id = params[:other_user_id].to_i
      @other_user = User.find_by(id: @other_user_id)

      if @other_user.nil?
        flash[:alert] = "User not found"
        redirect_to chats_path and return
      end

      # Find or create a private chat between current_user and the other user
      @chat = find_or_create_chat
    elsif params[:id].present?
      @chat = Chat.find_by(id: params[:id], is_private: true)
      if @chat.nil? || !@chat.chat_users.exists?(user_id: current_user.id)
        flash[:alert] = "Private chat not accessible"
        redirect_to chats_path and return
      end
      @other_user = @chat.chat_users.where.not(user_id: current_user.id).first&.user
    else
      flash[:alert] = "Invalid chat request"
      redirect_to chats_path and return
    end

    @focus_chat = @chat
    @messages = @chat.messages.order(created_at: :asc)
    @message = Message.new
    render :index
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
    current_user_id = current_user.id
    other_user_id = params[:other_user_id].to_i

    # Generate a unique name for the private chat
    chat_name = generate_chat_name(current_user_id, other_user_id)

    # Find or create the chat
    chat = Chat.find_or_create_by(name: chat_name, is_private: true)

    # Ensure both users are participants in the chat
    [ current_user_id, other_user_id ].each do |user_id|
      chat.chat_users.find_or_create_by(user_id: user_id)
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
