def template(from, to)
  	erb = File.read(File.expand_path("../templates/#{from}", __FILE__ ))
  	upload! StringIO.new(ERB.new(erb).result(binding)), to 
end

def set_default(name, value)
	set(name, value) unless fetch(name, false)
end

namespace :deploy do
  task :install do
  end
end

namespace :base do
  desc "Install everything on the server"
  task :install do
    on roles(:all) do
	  execute :sudo, "apt-get", "-y", "update"
	  execute :sudo, "apt-get", "-y", "install", "python-software-properties"
   	end
  end
end

after "deploy:install", "base:install"