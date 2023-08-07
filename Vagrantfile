# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.hostmanager.enabled = true 
  config.hostmanager.manage_host = true

  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.network "private_network", ip: "192.168.56.10"
    db.vm.provision "shell", path: "db.sh"
  end

  config.vm.define "host" do |host|
    host.vm.box = "ubuntu/focal64"
    host.vm.network "private_network", ip: "192.168.56.12"
    host.vm.network :forwarded_port, guest: 22, host: 2203
    host.vm.provision "shell", path: "odoo.sh"
  end
end
