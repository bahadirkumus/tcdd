require "test_helper"

class FollowTest < ActiveSupport::TestCase
  def setup
    @follow = follows(:one)
  end

  # Association tests
  test "should belong to follower" do
    assert @follow.follower.is_a?(User)
  end

  test "should belong to followed" do
    assert @follow.followed.is_a?(User)
  end

  # Validation tests
  test "should be valid with valid attributes" do
    assert @follow.valid?
  end

  test "should require a follower" do
    @follow.follower = nil
    assert_not @follow.valid?
  end

  test "should require a followed" do
    @follow.followed = nil
    assert_not @follow.valid?
  end

  test "should not allow duplicate follows" do
    duplicate_follow = @follow.dup
    assert_not duplicate_follow.valid?
  end

  test "should not allow a user to follow themselves" do
    @follow.follower = @follow.followed
    assert_not @follow.valid?
    assert_includes @follow.errors[:follower_id], "You cannot follow yourself"
  end
end
