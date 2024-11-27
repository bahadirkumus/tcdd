require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  include SessionsHelper
  test "invalid signup information" do
    get signup_path
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: "",
                                         surname: "",
                                         username: "",
                                         email: "invalidemail",
                                         password: "foo",
                                         password_confirmation: "bar",
                                         birthday: "",
                                         gender: "",
                                         bio: "",
                                         avatar_url: "invalidurl",
                                         location: "",
                                         status: "" } }
    end
    assert_template "users/new"
  end

  test "valid signup information" do
    get signup_path
    assert_difference "User.count", 1 do
      post users_path, params: { user: { name: "Example",
                                         surname: "User",
                                         username: "exampleuser0",
                                         email: "user@gmail.com",
                                         password: "Password1!",
                                         password_confirmation: "Password1!",
                                         birthday: "1990-01-01",
                                         gender: "male" } }
      puts @response.body
      user = assigns(:user)
      puts user.errors.full_messages unless user.valid?
    end
    follow_redirect!
    assert_template "users/show"
    assert logged_in?
  end
end
