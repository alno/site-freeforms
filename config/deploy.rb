set :application, "freeforms"
set :repository,  "git@github.com:alno/site-freeforms.git"

set :user, "freeforms"
set :use_sudo, false
set :deploy_to, "/home/freeforms/apps/freeforms"

server "s1.alno.name", :web, :app, :db, :primary => true

default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :scm, :git

default_environment['RAILS_ENV'] = 'production'

require 'bundler/capistrano'

namespace :deploy do

  desc "Restarting unicorn"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} ; script/delayed_job restart"
    run "cd #{current_path} ; ([ -f tmp/pids/unicorn.pid ] && kill -USR2 `cat tmp/pids/unicorn.pid`) || bundle exec unicorn -c config/unicorn.rb -E production -D"
  end

  desc "Rude restart application"
  task :rude_restart, :roles => :app do
    run "cd #{current_path} ; script/delayed_job stop; script/delayed_job start"
    run "cd #{current_path} ; pkill -f unicorn; sleep 0.5; pkill -f unicorn; sleep 0.5 ; bundle exec unicorn -c config/unicorn.rb -E production -D "
  end

  task :start, :roles => :app do
    rude_restart
  end

  after "deploy:migrate", :roles => :app do
    restart
  end
end

after "deploy:update_code", roles => :app do
  run "ln -nfs #{shared_path}/config/unicorn.rb #{release_path}/config/unicorn.rb"
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end
