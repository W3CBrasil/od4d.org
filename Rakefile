require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

task :deploy do
  # this will be use by capistrano to decide which git revision to deploy
  # if not provided, it will use master
  ENV['REVISION'] = ENV['SNAP_COMMIT'] if ENV['SNAP_CI']

  sh 'cap production deploy'
end
