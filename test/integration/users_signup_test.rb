require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference "User.count" do
      post user_registration_path, params: { user: { name: "",
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
    assert_template "devise/registrations/new"
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_difference "User.count", 1 do
      post user_registration_path, params: { user: { name: "Example",
                                                    surname: "User",
                                                    username: "exampleuser007",
                                                    email: "exampleuser007@gmail.com",
                                                    password: "Password0!",
                                                    password_confirmation: "Password0!",
                                                    birthday: "1990-01-01",
                                                    gender: "male" } }
    end
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]", destroy_user_session_path, count: 1 # Check if the logout link is present
    # assert user_signed_in?
  end
end
