# Settings specified here will take precedence over those in config/environment.rb

MAIL_HOST = 'localhost:3000'
APP_HOST = 'localhost:3000'
JS_HOST = 'localhost:3000'
FORM_CODE_PREFIX = '/forms'
FORM_CODE_SUFFIX = '/code'

#config.gem 'rspec', :lib => 'spec', :version => ">= 1.2.0"
#config.gem 'rspec-rails', :lib => 'spec/rails', :version => ">= 1.2.0" 

# Remarkable
config.gem 'remarkable'
config.gem 'remarkable_rails'
config.gem 'remarkable_activerecord'

# Machinist - blueprints
config.gem 'machinist'

# Testing emails
config.gem 'email_spec'

# The test environment is used exclusively to run your application's
# test suite.  You never need to work with it otherwise.  Remember that
# your test database is "scratch space" for the test suite and is wiped
# and recreated between test runs.  Don't rely on the data there!
config.cache_classes = true

# Log error messages when you accidentally call methods on nil.
config.whiny_nils = true

# Show full error reports and disable caching
config.action_controller.consider_all_requests_local = true
config.action_controller.perform_caching             = false
config.action_view.cache_template_loading            = true

# Disable request forgery protection in test environment
config.action_controller.allow_forgery_protection    = false

# Tell Action Mailer not to deliver emails to the real world.
# The :test delivery method accumulates sent emails in the
# ActionMailer::Base.deliveries array.
config.action_mailer.delivery_method = :test

# Use SQL instead of Active Record's schema dumper when creating the test database.
# This is necessary if your schema can't be completely dumped by the schema dumper,
# like if you have constraints or database-specific column types
# config.active_record.schema_format = :sql