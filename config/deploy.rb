# config valid only for Capistrano 3.1
lock "3.4.0"

set :application, "liberal-education-courses.umn.edu"
set :repo_url, "https://github.com/umn-asr/liberal_education_courses.git"

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, "/swadm/www/#{fetch(:application)}"
set :linked_files, %w(config/database.yml config/initializers/environment_variables.rb)
set :linked_dirs, %w(log tmp bin)
set :keep_releases, 5
set :tmp_dir, File.join(fetch(:deploy_to), "tmp")

set :passenger_restart_with_touch, true
