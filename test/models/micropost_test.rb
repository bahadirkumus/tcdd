require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = users(:one) # Assuming you have a user fixture
    @micropost = @user.microposts.build(content: "This is a valid micropost content")
  end

  test "should be valid with valid content" do
    assert @micropost.valid?
  end

  test "should be invalid with content less than 10 characters" do
    @micropost.content = "Too short"
    assert_not @micropost.valid?
    assert_includes @micropost.errors[:content], "Content must be between 10 and 140 characters"
  end

  test "should be invalid with content more than 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
    assert_includes @micropost.errors[:content], "Content must be between 10 and 140 characters"
  end

  test "should be valid with content exactly 10 characters" do
    @micropost.content = "1234567890"
    assert @micropost.valid?
  end

  test "should be valid with content exactly 140 characters" do
    @micropost.content = "a" * 140
    assert @micropost.valid?
  end
end