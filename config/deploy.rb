require 'bundler/capistrano'

set :application, "deal_hound"
set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
set :repository,  "git@github.com:akshay-vishnoi/Deal-Hound.git"
set :branch, 'master'

set :user, 'akshay'
set :use_sudo, false

set :domain, "54.232.30.181"

set :rails_env, 'production'
default_run_options[:pty] = true
# set :scm_command, "/usr/bin/git"
# set :local_scm_command, "/usr/local/bin/git"
set :deploy_to, "/var/www/apps/#{ application }"
set :deploy_via, :remote_cache
set :keep_releases, 5
server domain, :app, :web, :db, :primary => true


# role :web, "your web-server here"                          # Your HTTP server, Apache/etc
# role :app, "your app-server here"                          # This may be the same as your `Web` server
# role :db,  "your primary db-server here", :primary => true # This is where Rails migrations will run
# role :db,  "your slave db-server here"

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:

before 'deploy:restart', :copy_yml_files, 'assets:precompile'
after 'deploy:restart', 'unicorn:restart'

task :copy_yml_files do
  run "cp #{shared_path}/database.yml #{current_path}/config/database.yml"
end

namespace :assets do
  desc "Precompile assets after update_code"
  task :precompile, :roles => :app do
    run "cd #{current_path} ; RAILS_ENV=#{rails_env} bundle exec rake assets:precompile"
  end
end

namespace :unicorn do
  
  desc "Zero-downtime restart of Unicorn"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "kill -s USR2 `cat #{shared_path}/tmp/pids/unicorn.pid`"
  end

  desc "Start unicorn"
  task :start, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} ; bundle exec unicorn_rails -c config/unicorn.rb -D -E #{rails_env}"
  end

  desc "Stop unicorn"
  task :stop, :roles => :app, :except => { :no_release => true } do
    run "kill -s QUIT `cat #{shared_path}/tmp/pids/unicorn.pid`"
  end  
end

namespace :deploy do
  # task :start do ; end
  # task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end