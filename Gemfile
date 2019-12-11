source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.1'
# Use Puma as the app server
gem 'puma', '~> 4.3'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use ActiveStorage variant
# gem 'mini_magick', '~> 4.8'

gem 'pg', '~> 1.0'

gem 'jwt'

gem 'activerecord-import'

gem 'active_model_serializers'

gem 'rack-cors', :require => 'rack/cors'

gem 'sentry-raven', require: 'sentry-raven-without-integrations'

gem 'sidekiq', '~> 6.0.3'
gem 'sidekiq-status'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
# gem 'rack-cors'

group :development, :test do
  gem 'pry'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'capybara'
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '>= 3.0.5', '<= 3.2.0'
  gem 'bundle-audit'
  gem 'bullet'
  gem 'brakeman'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'
