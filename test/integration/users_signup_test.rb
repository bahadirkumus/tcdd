require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup information" do
    get new_user_registration_path
    assert_no_difference "User.count" do
      post user_registration_path, params: { user: { username: "",
                                                    email: "invalidemail",
                                                    password: "foo",
                                                    password_confirmation: "bar",
                                                    profile_attributes: {
                                                      name: "",
                                                      surname: "",
                                                      birthday: "",
                                                      gender: "",
                                                      bio: "",
                                                      avatar_url: "invalidurl",
                                                      location: "",
                                                      status: ""
                                                    } } }
    end
    assert_template "users/registrations/new"
  end

  test "valid signup information" do
    get new_user_registration_path
    assert_difference "User.count", 1 do
      post user_registration_path, params: { user: { username: "exampleuser007",
                                                    email: "exampleuser007@gmail.com",
                                                    password: "Password0!",
                                                    password_confirmation: "Password0!",
                                                    profile_attributes: {
                                                      name: "Example",
                                                      surname: "User",
                                                      birthday: "1990-01-01",
                                                      gender: "male",
                                                      bio: "This is a bio.",
                                                      avatar_url: "http://example.com/avatar.png",
                                                      location: "New York",
                                                      status: "Active"
                                                    } } }
    end
    follow_redirect!
    assert_template "verifications/new"
    assert_response :success
  end
end
