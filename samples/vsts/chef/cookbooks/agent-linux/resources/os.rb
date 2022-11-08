unified_mode true

default_action :upgrade

action :upgrade do
  apt_update '' do
    action :update
  end

  apt_package_os = [ 'net-tools', 'jq' ]
  apt_package apt_package_os do
    action :upgrade
  end

  bash 'apt dist-upgrade' do
    code <<-EOH
      apt-mark hold chef
      apt-get dist-upgrade -y -qq
      apt-get autoremove -y -qq
      apt-get clean -y -qq
      apt-mark unhold chef
    EOH
    not_if { shell_out('apt list --upgradable -qq | grep -v chef').stdout.empty? }
  end

  user 'vsts' do
    home '/home/vsts/'
    action :create
  end

  group 'vsts' do
    members [ 'vsts', shell_out('echo ${SUDO_USER:-${USER}}').stdout.strip ]
    action :create
  end

  directory '/home/vsts/' do
    owner 'vsts'
    group 'vsts'
    action :create
  end
end
