require "test_helper"

class NavbarLinksTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:valid_user) # fixture
  end

  # test "navbar links when not logged in" do
  #   # Visit the root path (home page)
  #   get root_path
  #   assert_template "static_pages/home"
  #
  #   # Check the Home link
  #   assert_select "a[href=?]", root_path, count: 1
  #
  #   # Check the Help link
  #   assert_select "a[href=?]", help_path, count: 1
  #
  #   # Check the About link
  #   assert_select "a[href=?]", about_path, count: 1
  #
  #   # Check the Login link
  #   assert_select "a[href=?]", new_user_session_path, count: 1
  #
  #   # Check the Register link
  #   assert_select "a[href=?]", new_user_registration_path, count: 1
  # end

  # test "navbar links when logged in" do
  #   sign_in @user
  #
  #   # Visit the root path (home page)
  #   get root_path
  #   assert_template "static_pages/home"
  #
  #   # Check the Home link
  #   assert_select "a[href=?]", root_path, count: 1
  #
  #   # Check the Help link
  #   assert_select "a[href=?]", help_path, count: 1
  #
  #   # Check the About link
  #   assert_select "a[href=?]", about_path, count: 1
  #
  #   # Check the Profile link
  #   assert_select "a[href=?]", user_path(@user.username), count: 1
  #
  #   # Check the Logout link
  #   assert_select "button#logout_button", count: 1
  #     end
end
