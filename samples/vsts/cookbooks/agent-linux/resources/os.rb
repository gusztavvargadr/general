unified_mode true

default_action :upgrade

action :upgrade do
  apt_update '' do
    action :update
  end

  bash 'apt dist-upgrade' do
    code <<-EOH
      apt dist-upgrade -y -qq
      apt autoremove -y -qq
      apt clean -y -qq
    EOH
    not_if { shell_out('apt list --upgradable -qq').stdout.empty? }
  end

  apt_package_os = [ 'net-tools', 'jq' ]
  apt_package apt_package_os do
    action :upgrade
  end
end
