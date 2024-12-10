require "test_helper"

class MessageTest < ActiveSupport::TestCase
  setup do
    @user = users(:valid_user)
    @chat = chats(:chat_one)
    @message = Message.new(content: "Test message", user: @user, chat: @chat)
  end

  test "should be valid with valid attributes" do
    assert @message.valid?
  end

  test "should not be valid without content" do
    @message.content = ""
    assert_not @message.valid?
  end

  test "should belong to a user" do
    assert_respond_to @message, :user
  end

  test "should belong to a chat" do
    assert_respond_to @message, :chat
  end
end
