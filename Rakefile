require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :deploy do
desc "Deploy to production"

  def deploy(environment)
    sh "cap #{environment} deploy"
  end

  def deploy_ci(environment)
    # this will be use by capistrano to decide which git revision to deploy
    # if not provided, it will use master
    ENV['REVISION'] = ENV['SNAP_COMMIT'] if ENV['SNAP_CI']

    configure_deploy_ssh_key
    sh "source ~/ssh-agent-exports && cap #{environment} deploy"
  end

  def configure_deploy_ssh_key
    server = ENV['OD4D_STAGING_SERVER'] || ENV['OD4D_PROD_SERVER']
    command = <<-eos
      echo "$DEPLOY_SSH_KEY" > ~/.ssh/deploy-key
      chmod 0600 ~/.ssh/deploy-key
      echo -e "\nHost #{server}\n\tUserKnownHostsFile /dev/null\n\tIdentityFile ~/.ssh/deploy-key\n\tForwardAgent yes" >> $HOME/.ssh/config
      ssh-agent > ~/ssh-agent-exports
      source ~/ssh-agent-exports && ssh-add ~/.ssh/deploy-key
    eos
    sh command
  end

  desc "Deploy to development"
  task :development do
    deploy("development")
  end

  desc "Deploy to staging"
  task :staging do
    deploy_ci("staging")
  end

  desc "Deploy to production"
  task :production do
    deploy_ci("production")
  end
end
