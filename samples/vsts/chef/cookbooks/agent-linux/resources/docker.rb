unified_mode true

default_action :upgrade

action :upgrade do
  apt_repository_arch = shell_out('dpkg --print-architecture').stdout.strip
  apt_repository 'docker' do
    uri 'https://download.docker.com/linux/ubuntu'
    key 'https://download.docker.com/linux/ubuntu/gpg'
    components ['stable']
    arch apt_repository_arch
    action :add
  end

  apt_package_docker = [ 'docker-ce', 'docker-compose-plugin' ]
  apt_package apt_package_docker do
    action :upgrade
  end

  group_docker_members = [ 'vsts', shell_out('echo ${SUDO_USER:-${USER}}').stdout.strip ]
  group 'docker' do
    append true
    members group_docker_members
    action :create
  end
end
