require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:valid_user) # fixture
  end

  test "should get new" do
    get new_user_session_path
    assert_response :success
  end

  test "login with valid email and password" do
    post user_session_path, params: { user: { login: @user.email, password: "Password!0" } }
    assert_redirected_to root_path
    follow_redirect!
    assert_template "static_pages/home"
    is_user_logged_in?
  end

  test "login with valid username and password" do
    post user_session_path, params: { user: { login: @user.username, password: "Password!0" } }
    assert_redirected_to root_path
    follow_redirect!
    assert_template "static_pages/home"
    is_user_logged_in?
  end

  test "login with invalid information" do
    post user_session_path, params: { user: { login: "", password: "" } }
    assert_template "users/sessions/new"
    assert_not flash.empty?
  end

  test "should log out" do
    sign_in @user
    delete destroy_user_session_path
    assert_redirected_to root_path
    follow_redirect!
    assert_select "a[href=?]", new_user_session_path, count: 1 # Check if the login link is present
  end
end
