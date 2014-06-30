server_address = "#{ENV['OD4D_PROD_SERVER']}"

raise "Please set the server address using the OD4D_PROD_SERVER environment variable" if server_address == ""

set :stage, :production
server server_address, user: 'od4d', roles: %w{web app}
