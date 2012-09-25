require "rvm/capistrano"
require "bundler/capistrano"

set :application, "acssj"

set :rvm_ruby_string, "ruby-1.9.2-p290"
set :rvm_type, :user
set :rvm_path, "$HOME/.rvm"
set :rvm_bin_path, "$HOME/.rvm/bin"

set :repository,  "git@github.com:mrapple/acssj.org.git"
set :scm, :git
set :branch, 'master'

set :deploy_to, "/home/deploy/apps/acssj"
set :deploy_via, :export
set :user, 'deploy'
set :shared_children, []

server 'zeus.oc.tc', :app, :web, :db, :primary => true

namespace :deploy do
  task :binstubs, :roles => :app, :except => { :no_release => true } do
    run "cd #{current_path} && bundle install --binstubs"
  end

  task :update do
    transaction do
      update_code
      build_code
      create_symlink
    end
  end

  task :build_code, :except => { :no_release => true } do
    run "staticmatic build #{latest_release}"
  end
end