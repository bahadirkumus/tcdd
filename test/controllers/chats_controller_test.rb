require "test_helper"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:valid_user)
    @other_user = users(:other_user)
    @chat = chats(:chat_one)
    @private_chat = chats(:private_chat)
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

  test "should create private chat" do
    assert_difference("Chat.count") do
      get private_chat_chats_url(other_user_id: @other_user.id)
    end

    assert_response :success
  end

  test "should show chat" do
    get chat_url(@chat)
    assert_response :success
    assert_select "h4", @chat.name
  end

  test "should show private chat" do
    get private_chat_chats_url(@private_chat, other_user_id: @other_user.id)
    assert_response :success
  end

  test "should not access another user's private chat" do
    sign_out @user
    sign_in @other_user
    get chat_url(@private_chat, other_user_id: @user.id)
    assert_redirected_to chats_url
    assert_equal "Private chats cannot be accessed through this route.", flash[:alert]
  end

  test "should send message in private chat" do
    post chat_messages_url(@private_chat), params: { message: { content: "Hello, this is another private message." } }
    puts @private_chat.messages.inspect
    assert_equal "Hello, this is another private message.", @private_chat.messages.last.content
  end

  test "should not send message in another user's private chat" do
    sign_out @user
    sign_in @other_user
    post chat_messages_url(@private_chat), params: { message: { content: "Hello" } }
    assert_response :unprocessable_entity
  end
end
