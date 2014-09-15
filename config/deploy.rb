lock '3.2.1'

set :application, 'od4d.org'
set :repo_url, 'git@github.com:w3cbrasil/od4d.org.git'
set :branch, ENV["REVISION"] || "master"

set :deploy_to, '/opt/od4d/od4d-org'

set :linked_files, %w{config/secrets.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  desc 'Deploy secrets'
  task :secrets do
    secret = ENV["SECRET_KEY_BASE"] || `bundle exec rake secret`
    secrets_file = File.read("config/secrets.yml").gsub(/{SECRET_KEY_BASE}/, secret)

    on roles(:app), in: :sequence, wait: 5 do
      unless test "[ -f #{shared_path}/config/secrets.yml ]"
        execute :mkdir, '-p', "#{shared_path}/config"
        upload! StringIO.new(secrets_file), "#{shared_path}/config/secrets.yml"
      end
    end
  end

  desc "Run a rake task on remote server"
  task :migrate do  
    on roles(:app), in: :sequence, wait: 5 do
      execute "cd #{deploy_to}/current; /usr/bin/env rake db:migrate RAILS_ENV=staging"
    end
  end

  before 'deploy:starting', 'deploy:secrets'
  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
  after :deploy, 'deploy:migrate'
end
