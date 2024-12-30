source "https://rubygems.org"

gem "rails", "~> 7.2.2"
gem "sprockets-rails"
gem "jbuilder"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "stimulus-rails"
gem "turbo-rails"
gem "devise", "~> 4.9"

gem "bootstrap", "~> 5.3.3"
gem "sassc-rails"

gem "jquery-rails", "~> 4.4.0"
gem "turbolinks"
gem "redis-rails", "~> 5.0"

gem 'carrierwave', '~> 2.0'

gem "bootsnap", require: false

group :development, :test do
  gem "brakeman", require: false
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "guard"
  gem "guard-puma"
  gem "ostruct" # After ruby version 3.5.0, ostruct is no longer included in the standard library
  gem "dotenv-rails"
  gem "rubocop-rails-omakase", require: false
  gem "ruby-lsp-rails", require: false
  gem "solargraph", require: false
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
end

group :development do
  gem "ruby-lsp-rails", require: false
  gem "web-console"
  gem "tzinfo-data", platforms: %i[windows jruby]
  gem "wdm", ">= 0.1.0", platforms: %i[windows]
end

group :test do
  gem "capybara"
  gem "guard-minitest"
  gem "minitest"
  gem "minitest-reporters"
  gem "rails-controller-testing"
  gem "selenium-webdriver"
  # gem "webdrivers"              # Do not use this for selenium. - Deprecated
  # gem "guard-livereload"        # guard-puma does livereload
  # gem 'guard-rspec'
end

group :production do
  gem "pg"
end
