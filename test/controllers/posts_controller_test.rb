require "test_helper"

class PostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "testuser", email: "test@example.com", password: "password")
    @valid_attributes = { post_type: "text_post", title:"Sample Test",body: "Sample post", user_id: @user.id }
    @invalid_attributes = { post_type: "text_post", body: "", user_id: @user.id }
  end

  test "should get new" do
    get new_post_path
    assert_response :success
  end

  #test "should create a valid post" do
  #  assert_difference("Posts::Post.count", 1) do
  #    post posts_path, params: { posts_post: @valid_attributes }
  #  end
  #  assert_redirected_to post_path(Posts::Post.last)
  #  follow_redirect!
  #  puts @response.body
  #end

  test "should not create an invalid post" do
    assert_no_difference("Posts::Post.count") do
      post posts_path, params: { posts_post: @invalid_attributes }
    end
    assert_response :unprocessable_entity
  end

  #test "should show post" do
  #  post = Posts::Post.create(@valid_attributes)
  #  assert_not_nil post.id
  #  get post_path(post)
  #  assert_response :success
  #end
end