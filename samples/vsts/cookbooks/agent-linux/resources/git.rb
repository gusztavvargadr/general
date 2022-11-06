unified_mode true

default_action :upgrade

action :upgrade do
  apt_repository 'git' do
    uri 'ppa:git-core/ppa'
    action :add
  end

  apt_package_git = [ 'git' ]
  apt_package apt_package_git do
    action :upgrade
  end
end
