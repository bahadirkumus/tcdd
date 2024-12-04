require "test_helper"

class ProfilesEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:valid_user)
    sign_in @user
  end

  test "invalid profile edit information" do
    get edit_profile_path(@user.username)
    assert_template "profiles/edit"
    patch profile_path(@user.username), params: { profile: { name: "",
                                                                    surname: "",
                                                                    birthday: "",
                                                                    gender: "",
                                                                    bio: "a" * 501,
                                                                    avatar_url: "invalidurl",
                                                                    location: "" } }
    assert_template "profiles/edit"
    assert_select "div#error_explanation"
  end

  test "valid profile edit information" do
    get edit_profile_path(@user.username)
    assert_template "profiles/edit"
    patch profile_path(@user.username), params: { profile: { name: "New Name",
                                                                    surname: "New Surname",
                                                                    birthday: "1990-01-01",
                                                                    gender: "male",
                                                                    bio: "This is a new bio.",
                                                                    avatar_url: "http://example.com/new_avatar.png",
                                                                    location: "New Location" } }
    @user.profile.reload
    assert_redirected_to user_path(@user.username)
    assert_equal "Profile updated", flash[:success]
    assert_equal "New Name", @user.profile.name
    assert_equal "New Surname", @user.profile.surname
    assert_equal Date.parse("1990-01-01"), @user.profile.birthday
    assert_equal "male", @user.profile.gender
    assert_equal "This is a new bio.", @user.profile.bio
    assert_equal "http://example.com/new_avatar.png", @user.profile.avatar_url
    assert_equal "New Location", @user.profile.location
  end
end
