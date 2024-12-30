ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

module SignInHelper
  def is_user_logged_in?
    !session[:user_id].nil?
  end

  def sign_in_as(user)
    if integration_test?
      post user_session_path, params: { 
        user: { 
          login: user.email,
          password: 'Password1!'
        }
      }
    else
      session[:user_id] = user.id
    end
  end

  private

  def integration_test?
    defined?(post_via_redirect)
  end
end

class ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  include SignInHelper

  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def setup
    Warden.test_mode!
  end

  def teardown
    Warden.test_reset!
  end
end

class ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  include Warden::Test::Helpers
  include SignInHelper

  def setup
    Warden.test_mode!
  end

  def teardown
    Warden.test_reset!
  end
end

class ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include SignInHelper
end
