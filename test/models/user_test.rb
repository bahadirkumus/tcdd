require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = create_user
    puts @user.errors.full_messages unless @user.valid?
  end

  # Helper method to create a user with default parameters
  def create_user(username: "test_user", email: "usertest@example.com",
                  password: "Password1!", password_confirmation: "Password1!")
    User.create(
      username: username,
      email: email,
      password: password,
      password_confirmation: password_confirmation,
      profile_attributes: {
        name: "John",
        surname: "Doe",
        birthday: "1990-01-01",
        gender: "male"
      }
    )
  end

  # General validations
  test "should be valid" do
    assert @user.valid?
  end

  test "email should be present" do
    @user.email = "     "
    assert_not @user.valid?
  end

  test "email should not be nil" do
    @user.email = nil
    assert_not @user.valid?
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
    invalid_usernames = %w[user@name use user.name user+name $asd 12345 !@#$%]
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
end
