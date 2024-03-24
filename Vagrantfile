Vagrant.configure("2") do |config|
  config.vm.define "samples", primary: true do |config|
    config.vm.box = "gusztavvargadr/docker-linux"

    config.vm.provision "shell", path: "./samples/initialize.sh", privileged: false
  end
end
