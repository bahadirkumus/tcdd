require "test_helper"

class PostsPostTest < ActiveSupport::TestCase
  setup do
    @user = User.create(username: "testuser", email: "test@example.com", password: "password")
  end

  test "valid text_post with body" do
    post = Posts::Post.new(post_type: "text_post", body: "Sample text post", user: @user)
    assert post.valid?
  end

  test "invalid text_post without body" do
    post = Posts::Post.new(post_type: "text_post", user: @user)
    assert_not post.valid?
    assert_includes post.errors[:body], "can't be blank"
  end

  test "valid photo_post with attached photo" do
    post = Posts::Post.new(post_type: "photo_post", user: @user)
    post.photo.attach(io: File.open("test/fixtures/files/sample.jpg"), filename: "sample.jpg", content_type: "image/jpeg")
    assert post.valid?
  end

  test "invalid photo_post without attached photo" do
    post = Posts::Post.new(post_type: "photo_post", user: @user)
    assert_not post.valid?
    assert_includes post.errors[:photo], "must be attached for photo posts."
  end

  test "invalid photo_post with wrong content type" do
    post = Posts::Post.new(post_type: "photo_post", user: @user)
    post.photo.attach(io: File.open("test/fixtures/files/sample.txt"), filename: "sample.txt", content_type: "text/plain")
    assert_not post.valid?
    assert_includes post.errors[:photo], "must be a PNG, JPG, or JPEG file."
  end
end