source "https://rubygems.org"


gem "rails", "~> 7.2.1", ">= 7.2.1.1"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"

gem "bootsnap", require: false

group :development, :test do
  gem "sqlite3"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  # gem "brakeman", require: false
  # gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem "rails-controller-testing"
  gem "minitest" 
  gem "minitest-reporters"
  gem "guard"     
  gem "guard-minitest"
  # gem 'guard-rspec'
  # gem 'guard-livereload'
end

group :production do
  # gem "pg"
end


#gem "tzinfo-data", platforms: %i[ windows jruby ]