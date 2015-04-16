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

 %w{start stop restart}.each do |command|
    desc "#{command} unicorn server"
    task command do
      on roles(:app) do
        execute "service unicorn_#{fetch(:application)} #{command}"
      end
    end
  end
  after :finishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
