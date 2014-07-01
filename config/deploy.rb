lock '3.2.1'

set :application, 'od4d.org'
set :repo_url, 'git@github.com:w3cbrasil/od4d.org.git'

set :deploy_to, '/opt/od4d-org'

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
end
