source "https://rubygems.org"

ruby "3.2.2"

gem "rails", "~> 8.0.2"
gem "propshaft"
gem "sqlite3", ">= 2.1", group: [ :development, :test ]
gem "pg", "~> 1.5"
gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false
gem "redis", ">= 4.0.1"
gem "sidekiq"
gem "sidekiq-scheduler"
gem "google-api-client"
gem "google-cloud-storage"
gem "dotenv-rails"
gem "devise"
gem "omniauth"
gem "omniauth-google-oauth2"

group :development, :test do
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "google-apis-youtube_v3", require: false
  gem "googleauth", require: false
  gem "rspec-rails"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "rack-mini-profiler"
  gem "ruby-prof"
  gem "stackprof"
  gem "memory_profiler"
  gem "rubocop", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "simplecov", "~> 0.22.0", group: :test
gem "webmock", "~> 3.25", group: :test
gem "mocha", "~> 2.7", group: :test

gem "attr_encrypted"
gem "blind_index"
gem "rack-attack"
# gem "secure_headers"
