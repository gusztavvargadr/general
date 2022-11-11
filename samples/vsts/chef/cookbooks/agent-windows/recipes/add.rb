gusztavvargadr_vsts_agent_windows_agent '' do
  action :add
  not_if { reboot_pending? }
end
