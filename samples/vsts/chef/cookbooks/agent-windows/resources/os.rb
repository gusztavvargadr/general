unified_mode true

default_action :upgrade

action :upgrade do
  updates_pending = powershell_out('(Get-WUInstall -MicrosoftUpdate).Count').stdout.strip

  powershell_script 'Disable Reserved Storage State' do
    code <<-EOH
      DISM.exe /Online /Set-ReservedStorageState /State:Disabled
    EOH
    action :run
    only_if { updates_pending != '0' }
    only_if { powershell_out('DISM.exe /Online /?').stdout.include?('/Set-ReservedStorageState') }
  end

  powershell_script 'Install Updates' do
    code <<-EOH
      Get-WUInstall -MicrosoftUpdate -Install -AcceptAll -IgnoreUserInput -IgnoreReboot
    EOH
    action :run
    only_if { updates_pending != '0' }
  end

  user 'vsts' do
    # home '/home/vsts/'
    action :create
  end

  directory '/Users/vsts/' do
    owner 'vsts'
    action :create
  end

  chocolatey_package 'gsudo' do
    action :upgrade
  end
end
