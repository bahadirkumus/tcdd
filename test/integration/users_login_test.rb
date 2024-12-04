require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:valid_user) # fixture
  end

  test "login with valid email and password" do
    get new_user_session_path
    assert_template "users/sessions/new"
    post user_session_path, params: { user: { login: @user.email, password: "Password!0" } }
    assert_redirected_to root_path
    follow_redirect!
    assert_template "static_pages/home"
    is_user_logged_in?
  end

  test "login with valid username and password" do
    get new_user_session_path
    assert_template "users/sessions/new"
    post user_session_path, params: { user: { login: @user.username, password: "Password!0" } }
    assert_redirected_to root_path
    follow_redirect!
    assert_template "static_pages/home"
    is_user_logged_in?
  end

  test "login with invalid information" do
    get new_user_session_path
    assert_template "users/sessions/new"
    post user_session_path, params: { user: { login: "", password: "" } }
    assert_template "users/sessions/new"
    assert_not flash.empty?
  end
end
