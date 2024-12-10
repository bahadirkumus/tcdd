require "test_helper"

class ChatTest < ActiveSupport::TestCase
  setup do
    @chat = Chat.new(name: "Test Chat Room")
  end

  test "should be valid with valid attributes" do
    assert @chat.valid?
  end

  test "should not be valid without a name" do
    @chat.name = ""
    assert_not @chat.valid?
  end

  test "should not be valid with a duplicate name" do
    duplicate_chat = @chat.dup
    @chat.save
    assert_not duplicate_chat.valid?
  end

  test "should have many messages" do
    assert_respond_to @chat, :messages
  end
end
