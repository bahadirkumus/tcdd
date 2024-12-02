# require "test_helper"

# class UsersEditTest < ActionDispatch::IntegrationTest
#   include Devise::Test::IntegrationHelpers

#   def setup
#     @user = users(:valid_user)
#     sign_in @user
#   end

#   test "invalid edit information" do
#     get edit_user_path(@user.username)
#     assert_template "users/edit"
#     patch user_path(@user.username), params: { user: { name: "",
#                                                        surname: "",
#                                                        username: "i",
#                                                        email: "invalid",
#                                                        password: "foo",
#                                                        password_confirmation: "bar",
#                                                        current_password: "invalid",
#                                                        bio: "",
#                                                        avatar_url: "invalidurl",
#                                                        location: "",
#                                                        gender: "",
#                                                        birthday: "" } }
#     assert_template "users/edit"
#     assert_select "div.error_explanation", "The form contains 7 errors."
#   end

#   test "valid edit information" do
#     get edit_user_path(@user.username)
#     assert_template "users/edit"
#     name = "New Name"
#     surname = "New Surname"
#     username = "newusername"
#     email = "newemail@example.com"
#     bio = "New bio"
#     avatar_url = "http://example.com/avatar.png"
#     location = "New Location"
#     gender = "male"
#     birthday = "1990-01-01"
#     patch user_path(@user.username), params: { user: { name: name,
#                                                        surname: surname,
#                                                        username: username,
#                                                        email: email,
#                                                        password: "",
#                                                        password_confirmation: "",
#                                                        current_password: "Password!0",
#                                                        bio: bio,
#                                                        avatar_url: avatar_url,
#                                                        location: location,
#                                                        gender: gender,
#                                                        birthday: birthday } }
#     assert_redirected_to user_path(username)
#     follow_redirect!
#     assert_not flash.empty?
#     @user.reload
#     assert_equal name, @user.name
#     assert_equal surname, @user.surname
#     assert_equal username, @user.username
#     assert_equal email, @user.email
#     assert_equal bio, @user.bio
#     assert_equal avatar_url, @user.avatar_url
#     assert_equal location, @user.location
#     assert_equal gender, @user.gender
#     assert_equal Date.parse(birthday), @user.birthday
#   end

#   test "valid edit information without password change" do
#     get edit_user_path(@user.username)
#     assert_template "users/edit"
#     name = "New Name"
#     surname = "New Surname"
#     username = "newusername"
#     email = "newemail@example.com"
#     bio = "New bio"
#     avatar_url = "http://example.com/avatar.png"
#     location = "New Location"
#     gender = "male"
#     birthday = "1990-01-01"
#     patch user_path(@user.username), params: { user: { name: name,
#                                                        surname: surname,
#                                                        username: username,
#                                                        email: email,
#                                                        password: "",
#                                                        password_confirmation: "",
#                                                        current_password: "Password!0",
#                                                        bio: bio,
#                                                        avatar_url: avatar_url,
#                                                        location: location,
#                                                        gender: gender,
#                                                        birthday: birthday } }
#     assert_redirected_to user_path(username)
#     follow_redirect!
#     assert_not flash.empty?
#     @user.reload
#     assert_equal name, @user.name
#     assert_equal surname, @user.surname
#     assert_equal username, @user.username
#     assert_equal email, @user.email
#     assert_equal bio, @user.bio
#     assert_equal avatar_url, @user.avatar_url
#     assert_equal location, @user.location
#     assert_equal gender, @user.gender
#     assert_equal Date.parse(birthday), @user.birthday
#   end
# end
