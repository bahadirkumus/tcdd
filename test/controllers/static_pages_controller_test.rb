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

  test "should get terms of service" do
    get terms_of_service_url
    assert_response :success
    assert_select "title", "Terms of Services | Soon"
  end
end
