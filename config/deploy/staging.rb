# frozen_string_literal: true

server '91.203.36.113', port: 10_622, roles: %i[web app db], primary: true
set :repo_url,        'git@gitlab.com:simax72/spree_ror.git'
# set :application,     'staging'
# set :user,            'prog'
set :puma_threads,    [4, 16]
set :puma_workers,    0
# set :branch, 'develop'
# set :deploy_to,       "/home/#{fetch(:user)}/www/newbkz/#{fetch(:application)}"
set :stage,           :staging
# Don't change these unless you know what you're doing
set :pty,             true
set :use_sudo,        false
# set :deploy_via,      :remote_cache

set :puma_bind,       "unix://#{shared_path}/tmp/sockets/#{fetch(:application)}-puma.sock"
set :puma_state,      "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,        "#{shared_path}/tmp/pids/puma.pid"
set :puma_access_log, "#{release_path}/log/puma.error.log"
set :puma_error_log,  "#{release_path}/log/puma.access.log"
set :ssh_options,     forward_agent: true, user: fetch(:user), keys: %w[~/.ssh/id_rsa.pub]
set :puma_preload_app, true
set :puma_worker_timeout, nil
set :puma_init_active_record, true # Change to false when not using ActiveRecord
## Defaults:
# set :scm,           :git
set :branch, :cropper
# set :format,        :pretty
# set :log_level,     :debug
# set :keep_releases, 5
## Linked Files & Directories (Default None):
# set :linked_files, %w{config/database.yml config/storage.yml config/cable.yml config/tinymce.yml}
# set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
namespace :puma do
  desc 'Create Directories for Puma Pids and Socket'
  task :make_dirs do
    on roles(:app) do
      execute "mkdir #{shared_path}/tmp/sockets -p"
      execute "mkdir #{shared_path}/tmp/pids -p"
    end
  end
  before :start, :make_dirs
end
