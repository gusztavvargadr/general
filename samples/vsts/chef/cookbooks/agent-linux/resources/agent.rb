unified_mode true

default_action :upgrade

action :upgrade do
  agent_version = '2.211.1'
  agent_arch = 'x64'

  agent_archive_name = "vsts-agent-linux-#{agent_arch}-#{agent_version}.tar.gz"
  agent_archive_download_uri = "https://vstsagentpackage.azureedge.net/agent/#{agent_version}/#{agent_archive_name}"
  agent_archive_local_path = "#{Chef::Config['file_cache_path']}/#{agent_archive_name}"

  remote_file agent_archive_local_path do
    source agent_archive_download_uri
    action :create
  end

  agent_local_path = "/opt/vsts/"
  archive_file agent_archive_local_path do
    destination agent_local_path
    owner 'vsts'
    group 'vsts'
    action :extract
    notifies :run, 'execute[installdependencies.sh]', :immediately
  end

  agent_install_dependencies_script_path = "./bin/installdependencies.sh"
  execute 'installdependencies.sh' do
    command agent_install_dependencies_script_path
    cwd agent_local_path
    action :nothing
  end
end

action :add do
  agent_local_path = "/opt/vsts/"
  agent_svc_script_path = "./svc.sh"
  agent_runsvc_script_path = "./runsvc.sh"
  env_file_path = "#{agent_local_path}.env"

  file env_file_path do
    content <<-EOH
CHEF_LICENSE=accept-silent

AZP_AGENT_LINUX=latest
AZP_AGENT_DOTNET=latest
AZP_AGENT_VAGRANT=latest
AZP_AGENT_PACKER=latest
AZP_AGENT_CHEF=latest
AZP_AGENT_DOCKER=latest
AZP_AGENT_VIRTUALBOX=latest
AZP_AGENT_UPLOAD=true

VSTS_AGENT_CAP_LINUX=ubuntu
VSTS_AGENT_CAP_DOCKER=linux
VSTS_AGENT_CAP_HYPERVISOR=virtualbox
VSTS_AGENT_CAP_NETWORK=upload
    EOH
    owner 'vsts'
    group 'vsts'
    action :create
  end

  agent_config_script_path = "./config.sh"
  agent_config_script_environment = {
    'VSTS_AGENT_INPUT_URL' => ENV['VSTS_AGENT_INPUT_URL'],
    'VSTS_AGENT_INPUT_AUTH' => 'pat',
    'VSTS_AGENT_INPUT_TOKEN' => ENV['VSTS_AGENT_INPUT_TOKEN'],
    'VSTS_AGENT_INPUT_POOL' => ENV['VSTS_AGENT_INPUT_POOL'],
    'VSTS_AGENT_INPUT_AGENT' => ::SecureRandom.hex,
  }
  execute 'config.sh' do
    command "#{agent_config_script_path} --unattended --acceptTeeEula"
    cwd agent_local_path
    user 'vsts'
    environment agent_config_script_environment
    action :run
    not_if { ::File.exist?(::File.expand_path(agent_svc_script_path, agent_local_path)) }
  end

  execute 'svc.sh-install' do
    command "#{agent_svc_script_path} install vsts"
    cwd agent_local_path
    action :run
    not_if { ::File.exist?(::File.expand_path(agent_runsvc_script_path, agent_local_path)) }
    notifies :run, 'execute[svc.sh-start]', :delayed
  end

  execute 'svc.sh-start' do
    command "#{agent_svc_script_path} start"
    cwd agent_local_path
    action :nothing
  end
end

action :remove do
  agent_local_path = "/opt/vsts/"
  agent_svc_script_path = "./svc.sh"

  execute 'svc.sh-stop' do
    command "#{agent_svc_script_path} stop"
    cwd agent_local_path
    action :run
  end

  execute 'svc.sh-uninstall' do
    command "#{agent_svc_script_path} uninstall"
    cwd agent_local_path
    action :run
  end

  agent_config_script_path = "./config.sh"
  agent_config_script_environment = {
    'VSTS_AGENT_INPUT_AUTH' => 'pat',
    'VSTS_AGENT_INPUT_TOKEN' => ENV['VSTS_AGENT_INPUT_TOKEN'],
  }
  execute 'config.sh' do
    command "#{agent_config_script_path} remove"
    cwd agent_local_path
    user 'vsts'
    environment agent_config_script_environment
    action :run
  end

  directory agent_local_path do
    recursive true
    action :delete
  end
end
