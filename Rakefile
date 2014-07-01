# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :deploy do
  if ENV['OD4D_PROD_SERVER'] == ""
    raise "Please set the server address using the OD4D_PROD_SERVER environment variable"
  end

  sh 'cap production deploy'
end
