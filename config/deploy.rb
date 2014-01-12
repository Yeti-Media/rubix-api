set :application, "anakin"
set :repository,  "git@github.com:Yeti-Media/anakin_app.git"

# set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "50.116.15.102"                          # Your HTTP server, Apache/etc
role :app, "50.116.15.102"                          # This may be the same as your `Web` server
role :db,  "50.116.15.102", :primary => true # This is where Rails migrations will run

set :user, "deploy"
set :deploy_to, "/home/#{user}/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :scm, "git"
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
ssh_options[:compression] = false


namespace :config do
  desc "[internal] Updates the symlink for database.yml file to the just deployed release."
  task :symlink, :except => { :no_release => true } do
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
    run "ln -nfs #{shared_path}/uploads #{latest_release}/public/uploads"
    run "ln -nfs #{shared_path}/vendor/bundle #{latest_release}/vendor/bundle"
    run "ln -nfs #{shared_path}/assets #{latest_release}/public/assets"
    run "ln -nfs #{latest_release}/bin/anakin64 #{latest_release}/bin/anakin"
  end
end

after  "deploy", "config:symlink"
after "deploy", "deploy:cleanup"
