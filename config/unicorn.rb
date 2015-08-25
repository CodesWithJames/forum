ROOT = "/home/ubuntu/apps/forum/current"

working_directory ROOT
preload_app true
pid "#{ROOT}/tmp/pids/forum.pid"
stderr_path "#{ROOT}/log/unicorn.log"
stdout_path "#{ROOT}/log/unicorn.log"

listen "/tmp/unicorn.forum.sock"
worker_processes 3
timeout 15

# Force the bundler gemfile environment variable to 
# reference the capistrano "current" symlink
before_exec do |_|
  ENV["BUNDLE_GEMFILE"] = File.join(ROOT, 'Gemfile')
end

before_fork do |server, worker|

  Signal.trap 'TERM' do
    puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
    Process.kill 'QUIT', Process.pid
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end