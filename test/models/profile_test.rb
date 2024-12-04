require "test_helper"

class ProfileTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid_user)
    @profile = @user.build_profile(
      name: "John",
      surname: "Doe",
      birthday: "1990-01-01",
      gender: "male",
      bio: "This is a bio.",
      avatar_url: "http://example.com/avatar.png",
      location: "New York"
    )
  end

  # General validations
  test "should be valid" do
    assert @profile.valid?
  end

  test "name should be present" do
    @profile.name = "     "
    assert_not @profile.valid?
  end

  test "surname should be present" do
    @profile.surname = "     "
    assert_not @profile.valid?
  end

  test "birthday should be present" do
    @profile.birthday = nil
    assert_not @profile.valid?
  end

  test "gender should be present" do
    @profile.gender = nil
    assert_not @profile.valid?
  end

  # Name and surname validations
  test "name should be at least 2 characters long" do
    @profile.name = "a"
    assert_not @profile.valid?
  end

  test "name should be at most 96 characters long" do
    @profile.name = "a" * 97
    assert_not @profile.valid?
  end

  test "surname should be at least 2 characters long" do
    @profile.surname = "a"
    assert_not @profile.valid?
  end

  test "surname should be at most 96 characters long" do
    @profile.surname = "a" * 97
    assert_not @profile.valid?
  end

  test "name and surname should be properly formatted" do
    test_cases = {
      "User  Name" => "User Name",
      "John  Doe" => "John Doe",
      " John" => "John",
      "John " => "John",
      " John Doe " => "John Doe",
      "Surname1  Surname2" => "Surname1 Surname2",
      "Smith  Johnson" => "Smith Johnson",
      "  John" => "John",
      "John  " => "John"
    }

    test_cases.each do |input, expected|
      @profile.name = input
      @profile.surname = input
      @profile.valid? # Trigger the before_validation callback
      assert_equal expected, @profile.name, "#{input.inspect} should be formatted to #{expected}"
      assert_equal expected, @profile.surname, "#{input.inspect} should be formatted to #{expected}"
    end
  end

  # Bio validations
  test "bio should be at most 500 characters long" do
    @profile.bio = "a" * 501
    assert_not @profile.valid?
  end

  # # Avatar URL validations
  # test "avatar_url should be valid format" do
  #   invalid_urls = %w[invalid_url http:/invalid.com]
  #   invalid_urls.each do |invalid_url|
  #     @profile.avatar_url = invalid_url
  #     assert_not @profile.valid?, "#{invalid_url.inspect} should be invalid"
  #   end
  # end

  # Location validations
  test "location should be at most 100 characters long" do
    @profile.location = "a" * 101
    assert_not @profile.valid?
  end
end
