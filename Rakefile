begin
  require 'achecker'
rescue LoadError
  puts "AChecker gem was not found. It is ok if you are not in development environment."
end

require File.expand_path('../config/application', __FILE__)


Rails.application.load_tasks

def get_server_from_env_variable(name)
  fail "Please set the server address using the environment variable #{name}" if ENV[name].to_s.empty?
  ENV[name]
end

def get_server(environment)
  case environment
  when "test"
    server = "app-server.dev"
  when "staging"
    server = get_server_from_env_variable('OD4D_STAGING_SERVER')
  when "production"
    server = get_server_from_env_variable('OD4D_PROD_SERVER')
  else
    fail "Environment '#{environment}' doesn't exist."
  end
  server
end

namespace :deploy do

  def deploy(environment)
    server = get_server(environment)
    command = get_ci_setup_command(server) if ENV['CI']
    sh "#{command} cap #{environment} deploy"
  end

  def get_ci_setup_command(server)
    "#{get_setup_revision_command}\n#{get_setup_ssh_command(server)}"
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

  desc "Deploy to test environment"
  task :test do
    deploy("test")
  end

  desc "Deploy to staging environment"
  task :staging do
    deploy("staging")
  end

  desc "Deploy to production environment"
  task :production do
    deploy("production")
  end

end

namespace :check do

  def get_app_urls(server)
    paths = `rake routes`
      .split("\n")
      .map{ |r| r.gsub(', ', ',').split(' ') }
      .map{ |r| r[2] }
      .map{ |r| r.gsub('(.:format)','') }
      .map{ |r| "http://#{server}#{r}"}
    paths[1..-1]
  end

  def get_achecker_api
    web_service_id = "#{ENV['ACHECKER_ID']}"
    fail "Please set the AChecker web service id using the environment variable 'ACHECKER_ID'" if web_service_id.empty?
    AChecker::Api.new(web_service_id)
  end

  desc "Web Accessibility Check"
  task :accessibility, [:environment] do |t, args|
    server = get_server(args.environment)
    achecker_api = get_achecker_api
    urls_with_errors = get_app_urls(server)
      .map { |url| achecker_api.check(url) }
      .select { |result| result.has_errors }
      .map { |result| result.url }

    unless urls_with_errors.empty?
      fail "The following urls failed the accessibility check, please go to http://achecker.ca to see the errors:\n#{urls_with_errors.join("\n")}"
    end
  end

end
