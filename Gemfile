source "https://rubygems.org"

gem "importmap-rails"
gem "jbuilder"
gem "puma", ">= 5.0"
gem "rails", "~> 7.2.1", ">= 7.2.1.1"
gem "sprockets-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "devise", "~> 4.9"

gem "bootstrap", "~> 5.1.3"
gem "jquery-rails", "~> 4.4.0"
gem "turbolinks"
gem "redis-rails", "~> 5.0"

gem "bootsnap", require: false

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "guard"
  gem "guard-puma"
  gem "ostruct" # After ruby version 3.5.0, ostruct is no longer included in the standard library
  gem "sqlite3"
  gem "dotenv-rails"
  gem "rubocop-rails-omakase", require: false
end

group :development do
  # gem 'rubocop'
  # gem 'rubocop-rails'
  gem "ruby-lsp-rails", require: false
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "guard-minitest"
  gem "minitest"
  gem "minitest-reporters"
  gem "rails-controller-testing"
  gem "selenium-webdriver"
  # gem "webdrivers" # Do not use this for selenium. - Deprecated
  # gem "guard-livereload" # guard-puma does livereload
  # gem 'guard-rspec'
end

group :production do
  gem "pg"
end

# gem "tzinfo-data", platforms: %i[ windows jruby ]
