require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid_user)
  end

  test "invalid edit username" do
    log_in_as(@user)
    get edit_username_user_path(@user.username)
    assert_template "users/edit_username"
    patch update_username_user_path(@user.username), params: { user: { username: "", password: "password" } }
    assert_template "users/edit_username"
    assert_select "div.alert", "Failed to update username. Please check the username."
  end

  test "edit username with invalid password" do
    log_in_as(@user)
    get edit_username_user_path(@user.username)
    assert_template "users/edit_username"
    patch update_username_user_path(@user.username), params: { user: { username: "valid", password: "invalid" } }
    assert_template "users/edit_username"
    assert_select "div.alert", "Incorrect password."
  end

  test "valid edit username" do
    log_in_as(@user)
    get edit_username_user_path(@user.username)
    assert_template "users/edit_username"
    new_username = "newusername"
    patch update_username_user_path(@user.username), params: { user: { username: new_username, password: "password" } }
    assert_redirected_to user_path(new_username)
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert_equal new_username, @user.username
  end

  test "invalid edit email" do
    log_in_as(@user)
    get edit_email_user_path(@user.username)
    assert_template "users/edit_email"
    patch update_email_user_path(@user.username), params: { user: { email: "invalid", password: "password" } }
    assert_template "users/edit_email"
    assert_select "div.alert", "Failed to update email. Please check the email address."
  end

  test "edit email with invalid password" do
    log_in_as(@user)
    get edit_email_user_path(@user.username)
    assert_template "users/edit_email"
    patch update_email_user_path(@user.username), params: { user: { email: "invalid@gmail.com", password: "invalid" } }
    assert_template "users/edit_email"
    assert_select "div.alert", "Incorrect password."
  end

  test "valid edit email" do
    log_in_as(@user)
    get edit_email_user_path(@user.username)
    assert_template "users/edit_email"
    new_email = "newemail@example.com"
    patch update_email_user_path(@user.username), params: { user: { email: new_email, password: "password" } }
    assert_redirected_to user_path(@user.username)
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert_equal new_email, @user.email
  end

  test "invalid edit password" do
    log_in_as(@user)
    get edit_password_user_path(@user.username)
    assert_template "users/edit_password"
    patch update_password_user_path(@user.username), params: { user: { current_password: "wrongpassword", password: "newpassword", password_confirmation: "newpassword" } }
    assert_template "users/edit_password"
    assert_select "div.alert", "Incorrect current password."
  end

  test "valid edit password" do
    log_in_as(@user)
    get edit_password_user_path(@user.username)
    assert_template "users/edit_password"
    patch update_password_user_path(@user.username), params: { user: { current_password: "password", password: "Newpassword1!", password_confirmation: "Newpassword1!" } }
    assert_redirected_to user_path(@user.username)
    follow_redirect!
    assert_not flash.empty?
    @user.reload
    assert @user.authenticate("Newpassword1!")
  end
end
