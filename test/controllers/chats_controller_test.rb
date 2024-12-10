require "test_helper"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid_user)
    @chat = chats(:chat_one)
    sign_in @user
  end

  test "should get index" do
    get chats_url
    assert_response :success
    assert_select "h4", "Chats"
  end

  test "should create chat" do
    assert_difference("Chat.count") do
      post chats_url, params: { chat: { name: "New Chat Room" } }
    end

    assert_response :success
  end

  test "should show chat" do
    get chat_url(@chat)
    assert_response :success
    assert_select "h4", @chat.name
  end

  # test "should destroy chat" do
  #   assert_difference("Chat.count", -1) do
  #     delete chat_url(@chat)
  #   end

  #   assert_redirected_to chats_url
  # end
end
