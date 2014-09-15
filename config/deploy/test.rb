set :stage, :test
set :rails_env, 'test'
server "app-server.dev", user: 'od4d', roles: %w{web app}
