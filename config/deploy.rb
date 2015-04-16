# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'capuchino'
set :repo_url, 'git@github.com:leminhtuan2015/capuchino.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/home/framgia/capuchino'

set :pty, true
set :sudo_prompt, ""
set :linked_files, %w{
  config/database.yml
  config/nginx.production.conf
  config/secrets.yml
  config/unicorn.rb
  config/unicorn_init.sh
}
set :linked_dirs, %w{ tmp log }
set :scm, :git
set :tmp_dir, "/home/#{fetch(:application)}/tmp"

namespace :deploy do

  desc "Start the Unicorn process when it isn't already running." 
    task :start do 
      run "cd #{current_path} && #{current_path}/bin/unicorn -Dc #{shared_path}/config/unicorn.rb -E #{rails_env}" 
    end

  desc "Initiate a rolling restart by telling Unicorn to start the new application code and kill the old process when done." 
    task :restart do 
      run "kill -USR2 $(cat #{shared_path}/pids/unicorn.pid)" 
    end

  desc "Stop the application by killing the Unicorn process" 
    task :stop do 
      run "kill $(cat #{shared_path}/pids/unicorn.pid)" 
    end

  after :finishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
    end
  end

end



