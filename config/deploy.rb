# config valid only for Capistrano 3.1
lock '3.4.0'

set :application, 'appointments'
set :repo_url, 'git@github.com:mgwidmann/appointments.git'

# Default branch is :master
set :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/appointments'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml db/staging.sqlite3 config/application.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
set :default_env, ENV.to_hash.slice("DEVISE_SECRET", "SECRET_KEY_BASE")

set :sidekiq_options_per_process, ["--queue high --queue default --queue low --queue mailers"]

# Default value for keep_releases is 5
# set :keep_releases, 5

set :bower_flags, '--quiet --config.interactive=false --allow-root'
set :bower_target_path, -> { "#{release_path}/vendor/assets" }

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
