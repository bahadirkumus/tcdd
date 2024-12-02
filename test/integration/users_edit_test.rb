require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:valid_user)
    sign_in @user
  end

  test "invalid edit username" do
    get edit_username_user_path(@user.username)
    assert_template "users/edit_username"
    patch update_username_user_path(@user.username), params: { user: { username: "", current_password: "Password!0" } }
    assert_template "users/edit_username"
    assert_select "div.alert", "Failed to update username. Please check the username."
  end

  test "edit username with invalid password" do
    get edit_username_user_path(@user.username)
    assert_template "users/edit_username"
    patch update_username_user_path(@user.username), params: { user: { username: "valid", current_password: "invalid" } }
    assert_template "users/edit_username"
    assert_select "div.alert", "Incorrect password."
  end

  test "valid edit username" do
    get edit_username_user_path(@user.username)
    assert_template "users/edit_username"
    new_username = "newusername"
    patch update_username_user_path(@user.username), params: { user: { username: new_username, current_password: "Password!0" } }
    assert_redirected_to user_path(new_username)
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert_equal new_username, @user.username
  end

  test "invalid edit email" do
    get edit_email_user_path(@user.username)
    assert_template "users/edit_email"
    patch update_email_user_path(@user.username), params: { user: { email: "invalid", current_password: "Password!0" } }
    assert_template "users/edit_email"
    assert_select "div.alert", "Failed to update email. Please check the email address."
  end

  test "edit email with invalid password" do
    get edit_email_user_path(@user.username)
    assert_template "users/edit_email"
    patch update_email_user_path(@user.username), params: { user: { email: "invalid@gmail.com", current_password: "invalid" } }
    assert_template "users/edit_email"
    assert_select "div.alert", "Incorrect password."
  end

  test "valid edit email" do
    get edit_email_user_path(@user.username)
    assert_template "users/edit_email"
    new_email = "newemail@example.com"
    patch update_email_user_path(@user.username), params: { user: { email: new_email, current_password: "Password!0" } }
    assert_redirected_to user_path(@user.username)
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert_equal new_email, @user.email
  end

  test "invalid edit password" do
    get edit_password_user_path(@user.username)
    assert_template "users/edit_password"
    patch update_password_user_path(@user.username), params: { user: { current_password: "wrongpassword", password: "newpassword", password_confirmation: "newpassword" } }
    assert_template "users/edit_password"
    assert_select "div.alert", "Incorrect current password."
  end

  test "valid edit password" do
    get edit_password_user_path(@user.username)
    assert_template "users/edit_password"
    patch update_password_user_path(@user.username), params: { user: { current_password: "Password!0", password: "Newpassword1!", password_confirmation: "Newpassword1!" } }
    assert_redirected_to user_path(@user.username)
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert @user.valid_password?("Newpassword1!")
  end
end
