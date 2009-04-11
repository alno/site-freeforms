set :application, "freeforms"
set :repository,  "http://svn.alno.name/rails/contact_forms"
set :deploy_to, "/home/industar/data/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :subversion
set :scm_username, "alno"
set :scm_password, "ChamIsCat"

server "alno.name", :app, :web, :db, :primary => true

set :user, "industar"
set :password, "tNvbf5KP"

set :use_sudo, false
set :group_writable, false

namespace :deploy do

   task :start, :roles => :app do
     run "cd #{current_path} && mongrel_rails cluster::start"
   end
 
   task :restart, :roles => :app do
     run "cd #{current_path} && mongrel_rails cluster::stop && rm #{deploy_to}/shared/pids/mongrel* && mongrel_rails cluster::start"
   end

end
