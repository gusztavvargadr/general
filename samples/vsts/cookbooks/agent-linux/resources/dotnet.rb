unified_mode true

default_action :upgrade

action :upgrade do
  system_version = node['lsb']['release']
  dotnet_packages_download_uri = "https://packages.microsoft.com/config/ubuntu/#{system_version}/packages-microsoft-prod.deb"
  dotnet_packages_local_path = "#{Chef::Config['file_cache_path']}/packages-microsoft-prod.deb"

  remote_file dotnet_packages_local_path do
    source dotnet_packages_download_uri
    action :create
  end

  dpkg_package 'dotnet-packages' do
    source dotnet_packages_local_path
    action :upgrade
  end

  apt_update '' do
    action :update
  end

  apt_package_dotnet = [ 'dotnet-sdk-3.1', 'dotnet-sdk-6.0' ]
  apt_package apt_package_dotnet do
    action :upgrade
  end
end
