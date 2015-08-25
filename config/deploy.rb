require "bundler/capistrano"
require "rvm/capistrano"

set :application, "forum"
server "52.21.22.32", :web, :app, :db, primary: true
set :port, 22
set :user, "ubuntu"
set :rails_env, 'production'

set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:xdougx/forum.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
before "deploy", "deploy:stop"
after "deploy", "deploy:start"

namespace :deploy do
  %w[start stop restart].each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: {no_release: true} do
      run "bash /home/#{user}/apps/#{application}/current/config/unicorn_init.sh #{command}"
      #run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end

  task :setup_config, roles: :app do
    run "mkdir -p #{shared_path}/config"
    # put File.read("config/mondoid.yml"), "#{shared_path}/config/mongoid.yml"
    puts "Now edit the config files in #{shared_path}."
  end

  task :build_configs, roles: :app do
    sudo "chmod a+x /home/#{user}/apps/#{application}/current/config/unicorn_init.sh"
    sudo "ln -nfs #{current_path}/config/forum.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/forum_init.sh /etc/init.d/unicorn_#{application}"
  end
  
  after "deploy:setup", "deploy:setup_config"

  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/mongoid.yml #{release_path}/config/mongoid.yml"
    run "ln -nfs #{shared_path}/config/secrets.yml #{release_path}/config/secrets.yml"
    run "ln -nfs #{shared_path}/config/application.yml #{release_path}/config/application.yml"
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
