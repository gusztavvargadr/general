gusztavvargadr_vsts_agent_linux_agent '' do
  action :add
  not_if { reboot_pending? }
end
