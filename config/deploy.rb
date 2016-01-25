require "bundler/capistrano"

set :application, "Content_Library"
set :repository,  "~/content_library/"
set :deploy_to, "/var/www/#{application}"

set :scm, :git
set :branch, "master"
set :deploy_via, :copy
set :shallow_clone, 1

set :user, nil	
set :password, nil
set :use_sudo, false

set :mysql_user, nil
set :mysql_password, nil

set :domain, nil
role :web, domain
role :app, domain
role :db,  domain, :primary => true

after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

after "deploy:setup", "db_yml:create"
after "deploy:update_code", "db_yml:symlink"

namespace :db_yml do
	desc "Create database.yml in shared path"
	task :create do
		config = {
			"production" =>
			{
				"adapter" => nil,
				"socket" => nil,
				"username" => mysql_user,
				"password" => mysql_password,
				"database" => nil
			}
		}
		put config.to_yaml, nil
	end

	desc "Make symlink for database.yml"
	task :symlink do
		run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
	end
end