require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :deploy do
desc "Deploy to production"

  def deploy(environment)
    command = get_ci_setup_command if ENV['CI']
    sh "#{command} cap #{environment} deploy"
  end

  def get_ci_setup_command
    "#{get_setup_revision_command}\n#{get_setup_ssh_command}"
  end

  def get_setup_revision_command
    # this will be use by capistrano to decide which git revision to deploy
    # if not provided, it will use master
    command = <<-eos
      REVISION=$SNAP_COMMIT
    eos
  end

  def get_setup_ssh_command
    server = ENV['OD4D_STAGING_SERVER'] || ENV['OD4D_PROD_SERVER']
    command = <<-eos
      echo "$DEPLOY_SSH_KEY" > ~/.ssh/deploy-key
      chmod 0600 ~/.ssh/deploy-key
      echo -e "\nHost #{server}\n\tUserKnownHostsFile /dev/null\n\tIdentityFile ~/.ssh/deploy-key\n\tForwardAgent yes" >> $HOME/.ssh/config
      $(ssh-agent)
      ssh-add ~/.ssh/deploy-key
    eos
  end

  desc "Deploy to development"
  task :development do
    deploy("development")
  end

  desc "Deploy to staging"
  task :staging do
    fail "Please set the server address using the environment variable OD4D_STAGING_SERVER" if ENV['OD4D_STAGING_SERVER'].to_s.empty?
    deploy("staging")
  end

  desc "Deploy to production"
  task :production do
    fail "Please set the server address using the environment variable OD4D_PROD_SERVER" if ENV['OD4D_PROD_SERVER'].to_s.empty?
    deploy("production")
  end
end
