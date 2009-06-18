require 'machinist/active_record'
require 'faker'
require 'sham'

Sham.name  { Faker::Name.name }
Sham.email { Faker::Internet.email }
Sham.title { Faker::Lorem.sentence }
Sham.body  { Faker::Lorem.paragraph }

Sham.description { Faker::Lorem.paragraph }

Sham.token { Faker::Lorem.sentence }

Dir[File.expand_path(File.dirname(__FILE__)) + "/blueprints/**/*_blueprint.rb"].each do |blueprint|
  require blueprint
end