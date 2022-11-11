unified_mode true

default_action :upgrade

action :upgrade do
  windows_feature_powershell 'Containers' do
    management_tools true
    action :install
  end
end
