gusztavvargadr_vsts_agent_windows_os '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_windows_git '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_windows_dotnet '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_windows_hashicorp '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_windows_chef '' do
  action :upgrade
end

gusztavvargadr_vsts_agent_windows_docker '' do
  action :upgrade
  not_if { reboot_pending? }
end

gusztavvargadr_vsts_agent_windows_hyperv '' do
  action :upgrade
  not_if { reboot_pending? }
end

gusztavvargadr_vsts_agent_windows_agent '' do
  action :upgrade
  not_if { reboot_pending? }
end

reboot 'upgrade' do
  action :request_reboot
  only_if { reboot_pending? }
end
