unified_mode true

default_action :upgrade

action :upgrade do
  chocolatey_package_dotnet = [ 'dotnetcore-3.1-sdk', 'dotnet-6.0-sdk' ]
  chocolatey_package chocolatey_package_dotnet do
    action :upgrade
  end
end
