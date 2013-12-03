require "bundler/capistrano"
require "rvm/capistrano"
require 'sidekiq/capistrano'
require 'intercity/capistrano'

server "10.10.60.156", :web, :app, :db, primary: true

set :application, "memmaker"
set :user, "deployer"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "origin git@gitlab.com:Lutak/memmaker.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
    puts "Now edit #{shared_path}/config/database.yml and add your username and password"
  end
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"
end

after "deploy:finalize_update", "gitlab:link"

namespace :gitshell do

  task :install do
    run "cd /home/git && git clone https://github.com/gitlabhq/gitlab-shell.git"
    run "cd /home/git/gitlab-shell && git checkout v1.7.0"
    upload "gitlab-shell.yml", "/home/git/gitlab-shell/config.yml"
    run "cd /home/git/gitlab-shell && ./bin/install"
  end

end

namespace :gitlab do

  desc "Install gitshell and configure gitlab."
  task :prepare do
    gitshell.install
    gitlab.configure
  end

  desc "Upload gitlab.yml and create gitlabl satellites directory."
  task :configure do
    upload "gitlab.yml", "/u/apps/#{application}/shared/config"
    run "cd /home/git && mkdir -p gitlab-satellites"
  end

  task :link do
    run "#{try_sudo} ln -nfs #{shared_path}/config/gitlab.yml #{release_path}/config/gitlab.yml"
  end

  desc "Executes bundle exec  rake gitlab:setup."
  task :setup do
    run "cd #{current_path} && bundle exec rake gitlab:setup RAILS_ENV=production force=yes"
  end

  desc "Backs up your gitlab"
  task :backup do
    run "cd #{current_path} && bundle exec rake gitlab:backup:create RAILS_ENV=production"
  end

end
