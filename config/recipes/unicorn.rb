set_default(:unicorn_user, "deployer" )
set_default(:unicorn_pid, "/home/deployer/apps/dep_app/current/tmp/pids/unicorn.pid" )
set_default(:unicorn_config, "/home/deployer/apps/dep_app/shared/config/unicorn.rb" )
set_default(:unicorn_log, "/home/deployer/apps/dep_app/shared/log/unicorn.log" )
set_default(:unicorn_workers, 2)

namespace :unicorn do
  desc "Setup Unicorn initializer and app configuration"
  task :setup do
    on roles(:app) do
      execute :mkdir, "-p", "/home/deployer/apps/dep_app/shared/config"
      template "unicorn.rb.erb", fetch(:unicorn_config)
      template "unicorn_init.erb", "/tmp/unicorn_init"
      execute :chmod, "+x", "/tmp/unicorn_init"
      execute :sudo, "mv", "/tmp/unicorn_init", "/etc/init.d/unicorn_#{fetch(:application)}"
      execute :sudo, "update-rc.d", "-f", "unicorn_#{fetch(:application)}", "defaults"
    end
  end
  after "deploy:finishing", "unicorn:setup"

  %w[start stop restart].each do |command|
    desc "#{command} unicorn"
    task command do
      on roles(:app) do
        execute :service, "unicorn_#{fetch(:application)}", "#{command}"
      end
    end
  end
  after "deploy:finishing", "unicorn:restart"
end 