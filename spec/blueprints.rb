require 'machinist/active_record'
require 'faker'

Dir[File.expand_path(File.dirname(__FILE__)) + "/blueprints/**/*_blueprint.rb"].each do |blueprint|
  require blueprint
end
