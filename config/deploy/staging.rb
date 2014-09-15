require "colorize"

server_address = "#{ENV['OD4D_STAGING_SERVER']}"

raise "Please set the server address using the OD4D_STAGING_SERVER environment variable".red if server_address.empty?

set :stage, :staging
set :rails_env, 'staging'
server server_address, user: 'od4d', roles: %w{web app}
