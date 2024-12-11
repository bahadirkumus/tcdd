class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])

    if @chat
      @message = @chat.messages.new(msg_params)
      @message.user = current_user

      if @message.save
        if @chat.is_private
          respond_to do |format|
            format.turbo_stream
            format.html { redirect_to private_chat_chats_path(@chat, other_user_id: @chat.users.where.not(id: current_user.id).first.id) }
          end
        else
        respond_to do |format|
          format.turbo_stream
          format.html { redirect_to chat_path(@chat) }
        end
        end
      else
        flash[:alert] = @message.errors.full_messages.to_sentence
        respond_to do |format|
          format.turbo_stream { render turbo_stream: turbo_stream.replace("messages", partial: "messages/messages", locals: { messages: @chat.messages }) }
          format.html { redirect_to chat_path(@chat) }
        end
      end
    end
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end
