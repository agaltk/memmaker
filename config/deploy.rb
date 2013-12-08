require "bundler/capistrano"
require "rvm/capistrano"
require 'sidekiq/capistrano'

server "10.10.60.156", :web, :app, :db, primary: true

set :application, "memmaker"
set :user, "deployer"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:agulek91/#{application}.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after 'deploy:update_code', 'deploy:migrate'
after 'deploy:update', 'deploy:symlink_attachments'
after 'deploy:update', 'deploy:symlink_tmp'
after 'deploy:update', 'deploy:clear_caches'
after 'deploy:update', 'deploy:cleanup'

# Run rake tasks
def run_rake(task, options={}, &block)
  command = "cd #{latest_release} && #{bundle_cmd} rake #{task}"
  run(command, options, &block)
end

namespace :puma do
  task :start, :except => { :no_release => true } do
    run "/etc/init.d/puma start #{application}"
  end
  after "deploy:start", "puma:start"

  task :stop, :except => { :no_release => true } do
    run "/etc/init.d/puma stop #{application}"
  end
  after "deploy:stop", "puma:stop"

  task :restart, roles: :app do
    run "/etc/init.d/puma restart #{application}"
  end
  after "deploy:restart", "puma:restart"
end

namespace :deploy do
  task :symlink_attachments do
    run "ln -nfs #{shared_path}/attachments #{release_path}/public/attachments"
  end

  task :symlink_tmp do
    run "rm -rf #{release_path}/tmp"
    run "ln -nfs #{shared_path}/tmp #{release_path}/tmp"
    run "chmod 775 #{shared_path}/tmp"
  end

  task :clear_caches do
    run "echo 'flush_all' | nc 10.10.60.156 80" # memcached
    run_rake "tmp:cache:clear >/dev/null 2>&1"
  end
end