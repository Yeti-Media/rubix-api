require 'capistrano/rbenv'

# config valid only for Capistrano 3.1
lock '3.1.0'

set :application, 'rubix_api'
set :repo_url, 'git@github.com:Yeti-Media/anakin_app.git'
set :rbenv_type, :user # or :system, depends on your rbenv setup
set :rbenv_ruby, '2.0.0-p451'
set :rbenv_path , '~/.rbenv'
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails}
set :rbenv_roles, :all # default value
# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
 set :deploy_to, '/home/deploy/rubix_api'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{public/uploads public/assets tmp}


# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

set :ssh_options, {
#    keys: %w(/home/rlisowski/.ssh/id_rsa),
  forward_agent: true,
  auth_methods: %w(publickey password)
}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app, :db), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      execute :touch, release_path.join('tmp/restart.txt')
      execute :ln, "-s #{release_path.join('bin/extractor64')} #{release_path.join('bin/extractor')}"
      execute :ln, "-s #{release_path.join('bin/trainer64')} #{release_path.join('bin/trainer')}"
    end
  end

  after :publishing, :restart


end
