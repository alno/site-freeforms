require 'yaml'

namespace :app do
  namespace :assets do

    desc "Merge and compress assets"
    task :package => :environment do
      Sass::Plugin.update_stylesheets
      Synthesis::AssetPackage.delete_all
      Synthesis::AssetPackage.build_all
    end
    
  end
end
