unified_mode true

default_action :upgrade

action :upgrade do
  apt_repository 'chef' do
    uri 'https://packages.chef.io/repos/apt/stable'
    key 'https://packages.chef.io/chef.asc'
    components ['main']
    action :add
  end

  apt_package_chef = [ 'chef-workstation' ]
  apt_package apt_package_chef do
    action :upgrade
  end
end
