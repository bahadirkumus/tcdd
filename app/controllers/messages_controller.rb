class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    @chat = Chat.find(params[:chat_id])
    @message = @chat.messages.new(msg_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.append("messages", partial: "messages/message", locals: { message: @message }) }
        format.html { head :no_content } # Provide a no-content response for non-Turbo requests
      end
    else
      flash.now[:alert] = @message.errors.full_messages.to_sentence
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("messages", partial: "messages/messages", locals: { messages: @chat.messages }) }
        format.html { head :unprocessable_entity } # Return a proper HTTP status code for errors
      end
    end
  end


  private

  def msg_params
    params.require(:message).permit(:content)
  end
end
