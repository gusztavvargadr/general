unified_mode true

default_action :upgrade

action :upgrade do
  apt_repository 'hashicorp' do
    uri 'https://apt.releases.hashicorp.com'
    key 'https://apt.releases.hashicorp.com/gpg'
    components ['main']
    action :add
  end

  apt_package_hashicorp = [ 'vagrant', 'packer', 'terraform', 'consul', 'vault' ]
  apt_package apt_package_hashicorp do
    action :upgrade
  end
end
