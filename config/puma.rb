rails_env = ENV['RAILS_ENV'] || 'development'

threads 0,60

bind "unix:///home/deployer/memmaker/shared/tmp/puma/appname-puma.sock"
pidfile "/home/deployer/memmaker/current/tmp/puma/pid"
state_path "/home/deployer/memmaker/current/tmp/puma/state"

activate_control_app
