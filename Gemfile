# frozen_string_literal: true

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "rails", "~> 6.1.5"
gem "puma", "~> 5.6"
gem "pg", groups: %i[development production]
gem "sqlite", groups: %i[test]
gem "sass-rails", ">= 6"
gem "webpacker", "~> 5.4"
gem "jbuilder", "~> 2.11"
gem "redis", "~> 4.6"
gem "image_processing", "~> 1.12"
gem "bootsnap", ">= 1.4.4", require: false
gem "tzinfo-data", platforms: %i[mingw mswin x64_mingw jruby]
gem "faker"
gem "devise"
gem "omniauth"
gem "omniauth-facebook"
gem "omniauth-rails_csrf_protection"
gem "cancancan"
gem "activeadmin"
gem "country_select"
gem "down"
gem "chartkick"
gem "mailgun-ruby"
gem "pagy"
gem "aws-sdk-s3"
gem "geocoder"
gem "countries"
gem "hotwire-rails"

group :development do
  gem "dotenv-rails"
  gem "byebug", platforms: %i[mri mingw x64_mingw]
  gem "web-console", ">= 4.1.0"
  gem "listen", "~> 3.7"
  gem "rack-mini-profiler", "~> 3.0"
  gem "spring"
  gem "rails-erd"
  gem "rubocop"
  gem "rubocop-performance"
  gem "rubocop-rails"
  gem "rubocop-packaging"
  gem "rubocop-rails_config"
end

group :test do
  gem "capybara", ">= 3.26"
  gem "selenium-webdriver"
  gem "webdrivers"
end
