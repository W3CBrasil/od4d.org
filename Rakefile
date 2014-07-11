require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :deploy do
desc "Deploy to production"

  def deploy(environment)
    # this will be use by capistrano to decide which git revision to deploy
    # if not provided, it will use master
    ENV['REVISION'] = ENV['SNAP_COMMIT'] if ENV['SNAP_CI']

    sh "cap #{environment} deploy"
  end

  desc "Deploy to development"
  task :development do
    deploy("development")
  end

  desc "Deploy to staging"
  task :staging do
    deploy("staging")
  end

  desc "Deploy to production"
  task :production do
    deploy("production")
  end
end
