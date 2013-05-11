source 'http://rubygems.org'

gem 'rails', '3.0.3'

gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'

gem 'will_paginate', ">= 3.0.pre2"
gem 'delayed_job', '>= 3.0.0'
gem 'delayed_job_active_record'
gem 'irwi'

gem 'jquery-rails'

gem 'csv_builder', :git => 'git://github.com/mreinsch/csv_builder.git'
gem 'ekuseru'

gem 'rails3_acts_as_paranoid', :git => 'git://github.com/goncalossilva/rails3_acts_as_paranoid.git', :branch => 'rails3.0'

gem 'exception_notification', :git => 'git://github.com/rails/exception_notification.git'

gem 'haml'
gem 'smart_chart'

gem 'unicorn'
gem 'daemons'

gem 'jsmin'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'sqlite3-ruby', :require => 'sqlite3'

  # Unit testing
  gem 'rspec-rails', '>= 2.1.0'
  gem 'email_spec', '>= 1.1.1'
  gem 'shoulda-matchers'

  gem 'faker'
  gem 'machinist', '>= 2.0.0.beta2'

  # Integration testing
  gem 'cucumber-rails'
  gem 'capybara', '>= 0.4.1.1'
  gem 'database_cleaner'

  gem 'ruby-debug'
  gem 'launchy'
end

# Deploy with Capistrano
# gem 'capistrano'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
