# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :deploy do
  if ENV['OD4D_PROD_SERVER'] == ""
    raise "Please set the server address using the OD4D_PROD_SERVER environment variable"
  end

  # this will be use by capistrano to decide which git revision to deploy
  # if not provided, it will use master
  ENV['REVISION'] = ENV['SNAP_COMMIT'] if ENV['SNAP_CI']

  sh 'cap production deploy'
end
