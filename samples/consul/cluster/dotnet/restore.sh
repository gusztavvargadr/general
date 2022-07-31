sudo apt update
sudo apt install -y apt-transport-https

wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
rm packages-microsoft-prod.deb

sudo apt update
sudo apt install -y dotnet-sdk-6.0

dotnet --info
dotnet tool list --global

docker pull mcr.microsoft.com/dotnet/runtime:6.0
docker pull mcr.microsoft.com/dotnet/aspnet:6.0
docker pull mcr.microsoft.com/dotnet/sdk:6.0
