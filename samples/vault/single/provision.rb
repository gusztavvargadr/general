ubuntu_codename = shell_out('lsb_release -cs').stdout.strip
ubuntu_architecture = shell_out('dpkg --print-architecture').stdout.strip

apt_update '' do
  action :update
end

apt_repository 'docker' do
  uri 'https://download.docker.com/linux/ubuntu'
  key 'https://download.docker.com/linux/ubuntu/gpg'
  distribution ubuntu_codename
  components ['stable']
  arch ubuntu_architecture
  action :add
end

apt_package_docker = [ 'docker-ce', 'docker-compose-plugin' ]
apt_package apt_package_docker do
  action :install
end

group_docker_members = shell_out('echo ${SUDO_USER:-${USER}}').stdout.strip
group 'docker' do
  append true
  members group_docker_members
  action :create
end

apt_repository 'hashicorp' do
  uri 'https://apt.releases.hashicorp.com'
  key 'https://apt.releases.hashicorp.com/gpg'
  distribution ubuntu_codename
  components ['main']
  action :add
end

apt_package_hashicorp = [ 'vault' ]
apt_package apt_package_hashicorp do
  action :install
end
