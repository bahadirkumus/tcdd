# require "test_helper"

# class FolkTest < ActiveSupport::TestCase
#   def setup
#     # Set up users and groups (folks) from fixtures
#     @valid_user = users(:valid_user)
#     @invalid_user_short_password = users(:invalid_user_short_password)
#     @other_user = users(:other_user)

#     @folk = folks(:one)  # "Test Group"
#     @chat = chats(:chat_one)  # "Public Chat Room"
#   end

#   test "user should be added to chat when joining a folk" do
#     # Initially, the user is not in the chat
#     assert_not @chat.users.include?(@valid_user)

#     # Simulate joining the group (folk)
#     @folk.users << @valid_user

#     # After joining, the user should be added to the chat
#     assert @chat.users.include?(@valid_user)
#   end

#   test "chat should be created when a folk is created" do
#     # When a new group (folk) is created, check if a chat is also created
#     folk = Folk.create!(name: "New Test Group", description: "A new test group")

#     # Verify that the chat is automatically created for this folk
#     assert_not_nil folk.chat
#     assert_equal folk.chat.name, "New Test Group Chat"
#   end
# end
