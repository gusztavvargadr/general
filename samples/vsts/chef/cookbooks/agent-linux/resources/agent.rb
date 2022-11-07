unified_mode true

default_action :upgrade

action :upgrade do
  agent_version = '2.211.1'
  agent_arch= 'x64'

  agent_archive_download_uri = "https://vstsagentpackage.azureedge.net/agent/#{agent_version}/vsts-agent-linux-#{agent_arch}-#{agent_version}.tar.gz"
  agent_archive_local_path = "#{Chef::Config['file_cache_path']}/vsts-agent-linux-#{agent_arch}-#{agent_version}.tar.gz"

  remote_file agent_archive_local_path do
    source agent_archive_download_uri
    action :create
  end

  agent_local_path = "#{Chef::Config['file_cache_path']}/vsts-agent/"
  archive_file agent_archive_local_path do
    destination agent_local_path
    action :extract
  end

  agent_install_script_path = "#{agent_local_path}bin/installdependencies.sh"
  execute 'installdependencies.sh' do
    command agent_install_script_path
    action :run
    # not_if
  end
end

# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_INPUT_URL", "https://dev.azure.com/gusztavvargadr/", "User")
# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_INPUT_AUTH", "pat", "User")

# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_CAP_LINUX", "latest", "User")
# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_CAP_DOTNET", "latest", "User")
# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_CAP_VAGRANT", "latest", "User")
# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_CAP_PACKER", "latest", "User")
# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_CAP_TERRAFORM", "latest", "User")
# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_CAP_CHEF", "latest", "User")
# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_CAP_DOCKER", "linux", "User")
# # [Environment]::SetEnvironmentVariable("VSTS_AGENT_CAP_HYPERVISOR", "virtualbox", "User")

# ## TODO Configure agents
