require "test_helper"

class FollowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @valid_user = users(:valid_user)
    @other_user = users(:other_user)
    Follow.delete_all # Remove all follow fixtures before testing
    sign_in @valid_user
  end

  #test "should follow user" do
  #  assert_difference("@valid_user.following.reload.count", 1) do
  #    post follow_user_path(@other_user.username)
  #  end
  #  assert_redirected_to user_path(@other_user.username)
  #  assert_equal "Successfully followed!", flash[:notice]
  #end

  #test "should unfollow user" do
  #  @valid_user.follow(@other_user)
  #  assert_difference("@valid_user.following.count", -1) do
  #    delete unfollow_user_path(@other_user.username)
  #  end
  #  assert_redirected_to user_path(@other_user.username)
  #  assert_equal "Unfollowed successfully.", flash[:notice]
  #end

  #test "should not follow non-existent user" do
  #  assert_no_difference("@valid_user.following.count") do
  #    post follow_user_path("non_existent_user")
  #  end
  #  assert_redirected_to root_path
  #  assert_equal "User not found.", flash[:alert]
  #end

  #test "should not unfollow non-existent user" do
  #  assert_no_difference("@valid_user.following.count") do
  #    delete unfollow_user_path("non_existent_user")
  #  end
  #  assert_redirected_to root_path
  #  assert_equal "User not found.", flash[:alert]
  #end
end
