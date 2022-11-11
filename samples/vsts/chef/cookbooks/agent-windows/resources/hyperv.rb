unified_mode true

default_action :upgrade

action :upgrade do
  windows_feature_powershell 'Hyper-V' do
    management_tools true
    action :install
  end
end
