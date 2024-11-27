require "test_helper"

class UsersLoginTest < ActionDispatch::IntegrationTest
  include SessionsHelper
  def setup
    @user = users(:valid_user) # fixture
  end

  test "login with valid email and password" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: { session: { login: @user.email, password: "password" } }
    assert_redirected_to user_path(@user.username)
    follow_redirect!
    assert_template "users/show"
    assert logged_in?
  end

  test "login with valid username and password" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: { session: { login: @user.username, password: "password" } }
    assert_redirected_to user_path(@user.username)
    follow_redirect!
    assert_template "users/show"
    assert logged_in?
  end

  test "login with invalid information" do
    get login_path
    assert_template "sessions/new"
    post login_path, params: { session: { login: "", password: "" } }
    assert_template "sessions/new"
    assert_not flash.empty?
  end
end
