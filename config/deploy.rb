# config valid only for Capistrano 3.1
lock "3.2.1"

set :application, "liberal-education-courses.umn.edu"
set :repo_url, "https://github.com/umn-asr/liberal_education_courses.git"

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/swadm/www/#{fetch(:application)}"
set :linked_files, %w(config/database.yml config/initializers/environment_variables.rb)
set :linked_dirs, %w(log tmp)
set :keep_releases, 5
set :tmp_dir, File.join(fetch(:deploy_to), "tmp")

namespace :deploy do
  desc "Restart application"
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join("tmp/restart.txt")
    end
  end

  after :publishing, :restart

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, "cache:clear"
      # end
    end
  end

end
