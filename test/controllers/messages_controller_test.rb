require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid_user)
    @chat = chats(:chat_one)
    @message = messages(:message_one)
    sign_in @user
  end

  test "should create message" do
    assert_difference("Message.count") do
      post chat_messages_url(@chat), params: { message: { content: "New message content" } }
    end
  end

  test "should not create message with invalid data" do
    assert_no_difference("Message.count") do
      post chat_messages_url(@chat), params: { message: { content: "" } }
    end

    assert_response :unprocessable_entity
    assert_not_empty flash[:alert]
  end
end
