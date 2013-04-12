require 'bundler/capistrano'

set :application, "deal_hound"
set :scm, :git
set :repository,  "git@github.com:akshay-vishnoi/Deal-Hound.git"
set :branch, 'master'

set :user, 'nakshay'
set :use_sudo, false

set :domain, "54.234.102.35"

set :rails_env, 'production'
default_run_options[:pty] = true
set :deploy_to, "/var/www/apps/#{ application }"
set :deploy_via, :remote_cache
set :keep_releases, 5
server domain, :app, :web, :db, :primary => true

before 'bundle:install', :copy_yml_files, 'assets:precompile'
after 'deploy:restart', 'unicorn:restart'

task :copy_yml_files do
  run "cp #{shared_path}/database.yml #{current_path}/config/database.yml"
  run "cp #{shared_path}/s3.yml #{current_path}/config/s3.yml"
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