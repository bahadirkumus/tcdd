require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "Soon"
  end

  test "should get about" do
    get about_url
    assert_response :success
    assert_select "title", "About | Soon"
  end

  test "should get terms of services" do
    get terms_of_service_url
    assert_response :success
    assert_select "title", "Terms of Services | Soon"
  end

  test "should get privacy policy" do
    get privacy_policy_url
    assert_response :success
    assert_select "title", "Privacy Policy | Soon"
  end

  test "should get cookies policy" do
    get cookies_policy_url
    assert_response :success
    assert_select "title", "Cookies Policy | Soon"
  end
end
