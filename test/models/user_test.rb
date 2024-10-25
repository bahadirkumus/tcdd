require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create_user
  end

  # Helper method to create a user with default parameters
  def create_user(name: "Example Name", surname: "Surname", username: "test_user", email: "user@example.com")
    User.create(
      name: name,
      surname: surname,
      username: username,
      email: email,
    )
  end

  # General validations
  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name = "     "
    assert_not @user.valid?
  end

  test "surname should be present" do
    @user.surname = "     "
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "name should not be nil" do
    @user.name = nil
    assert_not @user.valid?
  end

  test "surname should not be nil" do
    @user.surname = nil
    assert_not @user.valid?
  end

  test "email should not be nil" do
    @user.email = nil
    assert_not @user.valid?
  end

  test "name and surname should not include consecutive spaces" do
    invalid_strings = ["User  Name", "John  Doe", " John", " John Doe", "Surname1  Surname2", "Smith  Johnson"]
    invalid_strings.each do |invalid_string|
      @user.name = invalid_string
      assert_not @user.valid?, "#{invalid_string.inspect} should be invalid for name"
      @user.surname = invalid_string
      assert_not @user.valid?, "#{invalid_string.inspect} should be invalid for surname"
    end
  end

  # Email validations
  test "email should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email should be valid format" do
    invalid_emails = %w[user@example,com user_at_foo.org user.name@example.]
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?, "#{invalid_email.inspect} should be invalid"
    end
  end

  # Username validations
  test "username should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "username should be valid format" do
    invalid_usernames = %w[user@name use user.name user+name $asd 12345 !@#$%] # Abcd1 is going to be added
    invalid_usernames.each do |invalid_username|
      @user.username = invalid_username
      assert_not @user.valid?, "#{invalid_username.inspect} should be invalid"
    end
  end

  # Add more tests as needed...
end