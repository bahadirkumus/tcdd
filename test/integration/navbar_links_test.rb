require "test_helper"

class NavbarLinksTest < ActionDispatch::IntegrationTest
  test "navbar links" do
    # Visit the root path (home page)
    get root_path
    assert_template "static_pages/home"

    # Check the Home link
    assert_select "a[href=?]", root_path, count: 1

    # Check the Help link
    assert_select "a[href=?]", help_url, count: 1

    # Check the About link
    assert_select "a[href=?]", about_url, count: 1

    # Check the Login link
    assert_select "a[href=?]", login_url, count: 1

    # Check the Register link
    assert_select "a[href=?]", signup_url, count: 1
  end
end
