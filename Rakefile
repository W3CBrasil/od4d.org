require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

namespace :deploy do
desc "Deploy to production"

  def deploy(environment, server = nil)
    command = get_ci_setup_command(server) if ENV['CI']
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

  def get_setup_ssh_command(server)
    command = <<-eos
      echo "$DEPLOY_SSH_KEY" > ~/.ssh/deploy-key
      chmod 0600 ~/.ssh/deploy-key
      echo -e "\nHost #{server}\n\tUserKnownHostsFile /dev/null\n\tIdentityFile ~/.ssh/deploy-key\n\tForwardAgent yes" >> $HOME/.ssh/config
      ssh-agent > ~/ssh-agent_exports
      source ~/ssh-agent_exports
      ssh-add ~/.ssh/deploy-key
    eos
  end

  def get_server_from_env_variable(name)
    fail "Please set the server address using the environment variable #{name}" if ENV[name].to_s.empty?
    ENV[name]
  end

  desc "Deploy to test environment"
  task :test do
    deploy("test")
  end

  desc "Deploy to staging environment"
  task :staging do
    deploy("staging", get_server_from_env_variable('OD4D_STAGING_SERVER'))
  end

  desc "Deploy to production environment"
  task :production do
    deploy("production", get_server_from_env_variable('OD4D_PROD_SERVER'))
  end
end
