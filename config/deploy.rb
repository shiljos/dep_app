# load "config/recipes/base.rb"
# load "config/recipes/nginx.rb"
# load "config/recipes/unicorn.rb"
# load "config/recipes/postgresql.rb"
# load "config/recipes/nodejs.rb"
# load "config/recipes/rbenv.rb"
# #load "config/recipes/check.rb"

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'dep_app'
set :deploy_user, 'deployer'

set :scm, :git
set :repo_url, 'git@github.com:shiljos/dep_app.git'

set :rbenv_type, :user
set :rbenv_ruby, '2.1.0'
set :rbenv_bootstrap, "bootstrap-ubuntu-12-04"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}

# Default deploy_to directory is /var/www/my_app
#set :deploy_to, '/home/deployer/apps/dep_app'
# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug
#set :shared_p, '/home/deployer/apps/dep_app/shared'
# Default value for :pty is false
set :pty, true
set :ssh_options, { :forward_agent => true }

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set(:config_files, %w(
	nginx_unicorn
	database.yml
	unicorn.rb
	unicorn_init
))

#set(:executable_config_files, %w(unicorn_init))

#after "deploy", "deploy:cleanup"

