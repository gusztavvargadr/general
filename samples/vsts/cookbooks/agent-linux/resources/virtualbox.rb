unified_mode true

default_action :upgrade

action :upgrade do
  apt_repository 'virtualbox' do
    uri 'https://download.virtualbox.org/virtualbox/debian'
    key 'https://www.virtualbox.org/download/oracle_vbox_2016.asc'
    components ['contrib']
    arch shell_out('dpkg --print-architecture').stdout.strip
    action :add
  end

  apt_package_virtualbox = [ 'virtualbox-6.1' ]
  apt_package apt_package_virtualbox do
    action :upgrade
  end

  virtualbox_version = shell_out('vboxmanage --version').stdout.strip.split('r')[0]
  virtualbox_extension_pack_list = shell_out('vboxmanage list extpacks').stdout.strip
  return if virtualbox_extension_pack_list.include?(virtualbox_version)

  virtualbox_extension_pack_download_uri = "https://download.virtualbox.org/virtualbox/#{virtualbox_version}/Oracle_VM_VirtualBox_Extension_Pack-#{virtualbox_version}.vbox-extpack"
  virtualbox_extension_pack_local_path = "#{Chef::Config['file_cache_path']}/Oracle_VM_VirtualBox_Extension_Pack-#{virtualbox_version}.vbox-extpack"
  remote_file virtualbox_extension_pack_local_path do
    source virtualbox_extension_pack_download_uri
    action :create
  end

  bash 'vboxmanage extpack install' do
    code <<-EOH
      vboxmanage extpack install --replace --accept-license=33d7284dc4a0ece381196fda3cfe2ed0e1e8e7ed7f27b9a9ebc4ee22e24bd23c #{virtualbox_extension_pack_local_path}
    EOH
    action :run
  end
end
