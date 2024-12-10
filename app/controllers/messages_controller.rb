class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.build(msg_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_path(@chat) }
      end
    else
      flash[:alert] = @message.errors.full_messages.to_sentence
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("messages", partial: "messages/messages", locals: { messages: @chat.messages }) }
        format.html { redirect_to chat_path(@chat) }
      end
    end
  end

  private

  def msg_params
    params.require(:message).permit(:content)
  end
end
