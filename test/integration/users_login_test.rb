require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:valid_user) # fixture
  end

  test "login with valid email and password" do
    get new_user_session_path
    assert_template "devise/sessions/new"
    post user_session_path, params: { user: { login: @user.email, password: "password" } }
    assert_redirected_to user_path(@user.username)
    follow_redirect!
    assert_template "users/show"
    assert user_signed_in?
  end

  test "login with valid username and password" do
    get new_user_session_path
    assert_template "devise/sessions/new"
    post user_session_path, params: { user: { login: @user.username, password: "password" } }
    assert_redirected_to user_path(@user.username)
    follow_redirect!
    assert_template "users/show"
    assert user_signed_in?
  end

  test "login with invalid information" do
    get new_user_session_path
    assert_template "devise/sessions/new"
    post user_session_path, params: { user: { login: "", password: "" } }
    assert_template "devise/sessions/new"
    assert_not flash.empty?
  end
end
