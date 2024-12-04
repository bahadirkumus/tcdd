require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:valid_user)
    sign_in @user
  end

  test "invalid edit information" do
    get edit_user_path(@user.username)
    assert_template "users/edit"
    patch user_path(@user.username), params: { user: { username: "a",
                                                       email: "invalid",
                                                       password: "foo",
                                                       password_confirmation: "bar",
                                                       current_password: "invalid" } }
    assert_template "users/edit"
    assert_select "div#error_explanation"
  end

  test "invalid edit information with empty username" do
    get edit_user_path(@user.username)
    assert_template "users/edit"
    patch user_path(@user.username), params: { user: { username: "",
                                                       email: "invalid",
                                                       password: "foo",
                                                       password_confirmation: "bar",
                                                       current_password: "invalid" } }
    assert_template "users/edit"
    assert_equal "Username can't be blank", flash[:alert]
  end

  test "valid edit information" do
    get edit_user_path(@user.username)
    assert_template "users/edit"
    patch user_path(@user.username), params: { user: { username: "newusername",
                                                       email: "valid@gmail.com",
                                                       password: "Password!1",
                                                       password_confirmation: "Password!1",
                                                       current_password: "Password!0" } }
    @user.reload
    assert_equal @user.email, "valid@gmail.com"
    assert_redirected_to user_path(@user.username)
    assert_equal "User settings updated", flash[:success]
    is_user_logged_in?
  end

  test "valid edit information without password change" do
    get edit_user_path(@user.username)
    assert_template "users/edit"
    patch user_path(@user.username), params: { user: { username: "newusername",
                                                       email: "valid@gmail.com",
                                                       password: "",
                                                       password_confirmation: "",
                                                       current_password: "Password!0" } }
    @user.reload
    assert_equal @user.email, "valid@gmail.com"
    assert_redirected_to user_path(@user.username)
    assert_equal "User settings updated", flash[:success]
    is_user_logged_in?
  end
end
