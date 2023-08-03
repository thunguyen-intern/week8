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

  {"vm1" => "192.168.56.11", "vm2" => "192.168.56.12"}.each_with_index do |(vm_name, vm_ip), index|
    config.vm.define vm_name do |vm_config|
      vm_config.vm.box = "ubuntu/focal64"
      vm_config.vm.network "private_network", ip: vm_ip
      vm_config.vm.network "forwarded_port", guest: 8069, host: 8069 + index
      vm_config.vm.provision "shell", "path": "odoo.sh"
    end
  end
end
