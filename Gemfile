source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 5.0', '>= 5.0.5'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Use pg as the database for Active Record
gem 'pg', '~> 1.4.0'

gem 'dotenv-rails', '~> 2.7.6'

gem 'phonelib', '~> 0.7.0'

gem 'pundit', '~> 2.2.0'

gem 'jsonapi-resources', '~> 0.10'

group :development, :test do
  gem 'factory_bot_rails', '~> 6.2.0'
  gem 'faker', '~> 2.21.0'
  gem 'pry', '~> 0.14.1'
  gem 'rspec-rails', '~> 5.1.2'
  gem 'rubocop', require: false
  gem 'simplecov', '~> 0.21.2', require: false
  gem 'database_cleaner-active_record', '~> 2.0.1'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end
