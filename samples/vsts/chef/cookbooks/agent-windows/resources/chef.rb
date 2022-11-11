unified_mode true

default_action :upgrade

action :upgrade do
  chocolatey_package_chef = [ 'chef-workstation' ]
  chocolatey_package chocolatey_package_chef do
    action :upgrade
  end
end
