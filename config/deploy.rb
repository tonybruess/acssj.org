set :application, "acssj"
set :repository,  "git@github.com:mrapple/acssj.org.git"

set :deploy_to, "/var/www/#{application}"
set :deploy_via, :export
set :scm, :git
set :branch, 'master'
set :deploy_to, "/home/deploy/apps/acssj.org"
set :user, 'deploy'
set :shared_children, []

server 'zeus.oc.tc', :app, :web, :db, :primary => true

namespace :deploy do
  task :update do
    transaction do
      update_code
      build_code
      symlink
    end
  end

  task :build_code, :except => { :no_release => true } do
    run "staticmatic build #{latest_release}"
  end
end