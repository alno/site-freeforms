set :application, "freeforms"
set :repository,  "industar@freeforms.ru:/home/industar/data/git/freeforms.git"
set :deploy_to, "/home/industar/data/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :scm_username, "industar"
set :scm_password, "tNvbf5KP"

default_run_options[:pty] = true

set :deploy_via, :remote_cache

server "freeforms.ru", :app, :web, :db, :primary => true

set :user, "industar"
set :password, "tNvbf5KP"

set :use_sudo, false
set :group_writable, false

set :git_enable_submodules, 1
set :git_shallow_clone, 1

namespace :deploy do
  
  task :after_symlink, :roles => :web do
    run "cd #{current_path} && rake asset:packager:build_all --trace"
  end

  task :start, :roles => :app do
    run "cd #{current_path} && mongrel_rails start -d -e production -p 8000 -a 127.0.0.1 -P #{deploy_to}/shared/pids/mongrel.8000.pid -c #{current_path} --user industar --group industar"
  end
 
  task :restart, :roles => :app do
    run "cd #{current_path} && mongrel_rails stop -P #{deploy_to}/shared/pids/mongrel.8000.pid && mongrel_rails start -d -e production -p 8000 -a 127.0.0.1 -P #{deploy_to}/shared/pids/mongrel.8000.pid -c #{current_path} --user industar --group industar"
  end

end
