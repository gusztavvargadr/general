gusztavvargadr_vsts_agent_linux_os '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_linux_git '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_linux_dotnet '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_linux_hashicorp '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_linux_chef '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_linux_docker '' do
  action :upgrade
  not_if { reboot_pending? }
end

gusztavvargadr_vsts_agent_linux_virtualbox '' do
  action :upgrade
  not_if { reboot_pending? }
end

gusztavvargadr_vsts_agent_linux_agent '' do
  action :upgrade
  not_if { reboot_pending? }
end

# chef bootstrap
# os configuration
# dedicated user

# Vagrant configuration VAGRANT_DEFAULT_PROVIDER
# Vagrant boxes

# Packer configuration
# Packer isos

# Docker images

# Warm-up
