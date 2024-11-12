require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create_user
  end

  # Helper method to create a user with default parameters
  def create_user(name: "Example Name", surname: "Surname", username: "test_user", email: "user@example.com",
                  password: "Password1!", password_confirmation: "Password1!", birthday: "1990-01-01", role: "user",
                  gender: "male", followers_count: 0, following_count: 0, bio: "This is a bio.", avatar_url: "https://example.com/avatar.png",
                  location: "Somewhere", status: "active", last_seen_at: Time.now, confirmed_at: Time.now,
                  confirmation_token: SecureRandom.hex(10), preferences: { theme: "dark", notifications: true })
    User.create(
      name: name,
      surname: surname,
      username: username,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      birthday: birthday,
      role: role,
      gender: gender,
      followers_count: followers_count,
      following_count: following_count,
      bio: bio,
      avatar_url: avatar_url,
      location: location,
      status: status,
      last_seen_at: last_seen_at,
      confirmed_at: confirmed_at,
      confirmation_token: confirmation_token,
      preferences: preferences
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

  # Name and surname validations
  test "name should be at least 2 characters long" do
    @user.name = "a"
    assert_not @user.valid?
  end

  test "name should be at most 96 characters long" do
    @user.name = "a" * 97
    assert_not @user.valid?
  end

  test "surname should be at least 2 characters long" do
    @user.surname = "a"
    assert_not @user.valid?
  end

  test "surname should be at most 96 characters long" do
    @user.surname = "a" * 97
    assert_not @user.valid?
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
      @user.name = input
      @user.surname = input
      @user.valid? # Trigger the before_validation callback
      assert_equal expected, @user.name, "#{input.inspect} should be formatted to #{expected}"
      assert_equal expected, @user.surname, "#{input.inspect} should be formatted to #{expected}"
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

  test "username should be at least 4 characters long" do
    @user.username = "abc"
    assert_not @user.valid?
  end

  test "username should be at most 16 characters long" do
    @user.username = "a" * 17
    assert_not @user.valid?
  end

  test "username should be downcased before validation" do
    mixed_case_username = "TeSt_UsEr"
    @user.username = mixed_case_username
    @user.valid?
    assert_equal mixed_case_username.downcase, @user.username
  end

  # Password validations
  test "password should be present" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should not be nil" do
    @user.password = @user.password_confirmation = nil
    assert_not @user.valid?
  end

  test "password should be at least 8 characters long" do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

  test "password should be at most 72 characters long" do
    @user.password = @user.password_confirmation = "a" * 73
    assert_not @user.valid?
  end

  test "password should be valid format" do
    invalid_passwords = %w[password Password PASSWORD passw0rd passw0rd! passw0rd123 passw0rd!@# passw0rd!@#123]
    invalid_passwords.each do |invalid_password|
      @user.password = @user.password_confirmation = invalid_password
      assert_not @user.valid?, "#{invalid_password.inspect} should be invalid"
    end
  end

  test "password should match confirmation" do
    @user.password_confirmation = "mismatch"
    assert_not @user.valid?
  end

  # Some additional tests
end
