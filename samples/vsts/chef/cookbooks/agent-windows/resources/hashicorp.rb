unified_mode true

default_action :upgrade

action :upgrade do
  chocolatey_package_hashicorp = [ 'vagrant', 'packer', 'terraform' ]
  # chocolatey_package_hashicorp = [ 'vagrant', 'packer', 'terraform', 'consul', 'vault' ]
  chocolatey_package chocolatey_package_hashicorp do
    returns [ 0, 2, 3010 ]
    action :upgrade
    notifies :request_reboot, 'reboot[hashicorp-upgrade]'
  end

  reboot 'hashicorp-upgrade' do
    action :nothing
  end
end
