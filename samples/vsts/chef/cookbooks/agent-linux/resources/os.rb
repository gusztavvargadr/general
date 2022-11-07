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
      apt dist-upgrade -y -qq
      apt autoremove -y -qq
      apt clean -y -qq
      apt-mark unhold chef
    EOH
    not_if { shell_out('apt list --upgradable -qq | grep -v chef').stdout.empty? }
  end
end
