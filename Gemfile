source 'http://rubygems.org'

gem 'rails', '~> 3.0.0'

gem 'authlogic', :git => 'git://github.com/odorcicd/authlogic.git', :branch => 'rails3'

gem 'will_paginate', ">= 3.0.0"
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

gem 'rake', '0.8.7'

group :production do
  gem 'pg'
end

group :development, :test do
  gem 'capistrano'
  gem 'sqlite3-ruby', :require => 'sqlite3'

  # Unit testing
  gem 'rspec-rails', '>= 2.1.0'
  gem 'email_spec', '>= 1.1.1'
  gem 'shoulda-matchers'

  gem 'faker'
  gem 'machinist', '>= 2.0.0.beta2'

  # Integration testing
  gem 'cucumber-rails', :require => false
  gem 'capybara', '~> 2.0.0'
  gem 'database_cleaner'
end
