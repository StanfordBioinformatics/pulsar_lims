source 'https://rubygems.org'
ruby "2.2.2"

#Add production webserver gem for Puma
gem "puma", group: :production
gem 'rails_12factor', group: :production

gem 'active_model_serializers', '~> 0.9.3' 

gem 'devise', '~> 3.4.1'
gem 'pundit', '~> 0.3.0'

gem 'carrierwave', '~> 0.10.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'json'
gem 'rails', '~> 4.2.1'

# Use sqlite3 as the database for Active Record
#gem 'sqlite3'
#Use PostgreSQL
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails'

#Use Bootstrap (nathankw added)
gem 'sprockets-rails', '~> 2.1.4'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'font-awesome-rails', '~> 4.3'
gem 'simple_form', '~> 3.1.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
#Add jQuery UI
#gem 'jquery-ui-rails' #conflicts with Bootstrap

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :development, :test do
	gem 'rspec-rails'
end

group :test do
	gem 'capybara', '~> 2.4' #used for integration testing. 
	gem 'factory_girl_rails', '~> 4.5'
end
# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
