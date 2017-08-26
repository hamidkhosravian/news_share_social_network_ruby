source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "rails", "~> 5.1.3"
# Use postgresql as the database for Active Record
gem "pg", "~> 0.18"
# Use Puma as the app server
gem "puma", "~> 3.7"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
# Use Redis adapter to run Action Cable in production
gem "redis", "~> 3.0"
gem "redis-rails"
# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"
# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem "rack-cors"

# authentication and authorization
# gem "knock"
gem "jwt"
gem "devise"
gem "cancancan"
gem "omniauth-twitter"
gem "omniauth-facebook"
gem "omniauth-linkedin"
gem "omniauth-google-oauth2"

# database related
gem "kaminari"
gem "ransack"
gem "seedbank"

# Configuration
gem "figaro"

# RESTapi
gem "rails_param"

# Async
gem "sidekiq"
gem "sidekiq-status"
gem "sidekiq-failures"
gem "sidekiq-cron"

# Validation
gem "validates_timeliness"
gem "valid_url"

# Error Tracker
# gem "airbrake", "~> 6.0"

# Upload Handler
gem "paperclip", "~> 5.1.0"

# mailchimp gem
gem "gibbon"

# Social Network Gems
gem "geocoder"
gem "acts_as_votable"
gem "acts-as-taggable-on"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
  gem "bullet"
  gem "faker"
  gem "factory_girl_rails"
  gem "rubocop", require: false
  gem "rspec-rails", "~> 3.5"
  gem "dry-validation"
  gem "jmespath"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  # Use Capistrano for deployment
  gem "capistrano-rails"
  gem "rubycritic", require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
