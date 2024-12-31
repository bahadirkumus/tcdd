# require "test_helper"

# class FolksControllerTest < ActionDispatch::IntegrationTest
#   def setup
#     @user = users(:valid_user)
#     @folk = folks(:one)
#     @chat = chats(:chat_one)
#     sign_in @user
#   end

#   test "should add user to chat when joining a folk" do
#     # Assert the initial state: user is not in the chat
#     assert_not @chat.users.include?(@user)

#     # Simulate the user joining the group
#     post join_folk_url(@folk)

#     # Verify that after joining, the user is in the chat
#     assert @chat.users.include?(@user)
#   end

#   test "should create chat when a new folk is created" do
#     assert_difference 'Chat.count', 1 do
#       post folks_url, params: { folk: { name: "New Group", description: "A new test group" } }
#     end

#     # Check that the created folk has an associated chat
#     folk = Folk.last
#     assert_not_nil folk.chat
#     assert_equal folk.chat.name, "New Group Chat"
#   end

#   test "should not allow invalid user to join a folk" do
#     invalid_user = users(:invalid_user_short_password)

#     # Try adding an invalid user to a group (folk)
#     post join_folk_url(@folk), params: { user_id: invalid_user.id }

#     # Assert that the user has not been added to the chat
#     assert_not @folk.chat.users.include?(invalid_user)
#   end
# end
