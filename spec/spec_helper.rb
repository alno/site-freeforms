# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'

require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require File.expand_path(File.dirname(__FILE__) + "/blueprints")

require 'rspec/rails'

require "email_spec/helpers"
require "email_spec/matchers"

Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

RSpec.configure do |config|

  config.include EmailSpec::Helpers
  config.include EmailSpec::Matchers

  config.mock_with :rspec

  config.use_transactional_fixtures = true

end
