source 'https://rubygems.org'
ruby '2.0.0'
#ruby-gemset=kinfonet4

gem 'rails', '4.0.0'
gem 'pg'
#gem 'bootstrap-sass', '2.3.2.0'
gem 'bootstrap-sass', :git => 'git://github.com/thomas-mcdonald/bootstrap-sass.git', :branch => '3'
gem 'devise'
gem 'faker', '1.1.2'
gem 'will_paginate', '3.0.4'
gem 'bootstrap-will_paginate', '0.0.9'

group :development, :test do
  gem 'rspec-rails', '2.13.1'
  gem 'spork-rails', github: 'sporkrb/spork-rails'
   gem 'annotate'
end

group :test do
  #gem 'selenium-webdriver', '2.0.0'
  gem 'capybara', '2.1.0'
  gem 'factory_girl_rails', '4.2.0'

  # cucumber issues with rails4
  #pull out cucumber
  gem 'cucumber-rails', '1.3.0', :require => false
  gem 'database_cleaner', github: 'bmabey/database_cleaner'
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
