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
  	db.vm.synced_folder ".", "/vagrant_data"
	#db.vm.provision "shell", path: "./provision/psql.sh"
  end
  config.vm.define "srv" do |srv|
	srv.vm.box = "ubuntu/focal64"
  	srv.vm.network "private_network", ip: "192.168.56.11"
  	srv.vm.synced_folder ".", "/vagrant_data"
	#srv.vm.provision "shell", path: "./provision/odoo.sh"
  end
end
