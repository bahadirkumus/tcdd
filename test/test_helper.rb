ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/reporters"
Minitest::Reporters.use!

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)
        # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
        fixtures :all

        include Devise::Test::IntegrationHelpers
        include Warden::Test::Helpers
        include ApplicationHelper
  end
end
