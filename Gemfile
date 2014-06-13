source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=kinfonet4
#http://guides.rubyonrails.org/upgrading_ruby_on_rails.html
gem 'rails', '4.1'
gem 'pg'
gem 'thin'

gem 'bootstrap-sass', '~> 3.1.0'
gem 'devise'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '~> 0.0.9'
gem 'bootstrap-datepicker-rails'
gem 'pg_search'
gem "paperclip"

gem 'quiet_assets', :group => :development
group :development, :test do
  gem 'rspec-rails', '~> 2.13.1'
  gem 'spork-rails', '4.0.0'
  gem 'childprocess', '~> 0.3.6'
  gem 'annotate'
end

group :test do
  gem 'selenium-webdriver', '~> 2.35.1'
  gem 'capybara', '~> 2.1.0'
  gem 'factory_girl_rails', '~> 4.2.0'
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
  gem 'minitest' #https://github.com/rspec/rspec-rails/issues/758
end

gem 'sass-rails', '~> 4.0.0'
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
gem 'jquery-rails'
gem 'haml-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  gem 'rails_12factor', '~> 0.0.2'
end
