unified_mode true

default_action :upgrade

action :upgrade do
  chocolatey_package 'git' do
    options '--params "/NoShellIntegration /SChannel /NoOpenSSH"'
    action :upgrade
  end
end
