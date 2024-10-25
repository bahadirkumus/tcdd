source "https://rubygems.org"


gem "rails", "~> 7.2.1", ">= 7.2.1.1"
gem "sprockets-rails"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "bcrypt", "~> 3.1.7"

gem 'bootstrap', '~> 5.1.3'
gem 'jquery-rails', '~> 4.4.0'
gem 'turbolinks'

gem "bootsnap", require: false

group :development, :test do
  gem "sqlite3"
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "ostruct" # After ruby version 3.5.0, ostruct is no longer included in the standard library
  # gem "brakeman", require: false
  # gem "rubocop-rails-omakase", require: false
end

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
  gem "rails-controller-testing"
  gem "minitest" 
  gem "minitest-reporters"
  gem "guard"     
  gem "guard-minitest"
  gem "guard-puma"
  # gem "webdrivers" # Do not use this for selenium. - Deprecated
  # gem "guard-livereload" # guard-puma does livereload
  # gem 'guard-rspec'
end

group :production do
  # gem "pg"
end


#gem "tzinfo-data", platforms: %i[ windows jruby ]

