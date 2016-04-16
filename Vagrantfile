# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "oracle11g-xe-oel7"
  config.vm.box_url = "http://cloud.terry.im/vagrant/oraclelinux-7-x86_64.box"
  config.vm.hostname = "oracle.vm"

  config.vm.provider "virtualbox" do |vb|
    vb.gui = false
    vb.memory = "512"
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vbguest.auto_update = true

  config.vm.provision :shell, :inline => "sudo su -c 'echo LANG=en_US.utf-8 >> /etc/environment && echo LC_ALL=en_US.utf-8 >> /etc/environment'"
  config.vm.provision :shell, :inline => "sudo rm /etc/localtime && sudo ln -s /usr/share/zoneinfo/UTC /etc/localtime"
  config.vm.provision :shell, :inline => "sudo yum update -y --skip-broken"
  config.vm.provision :shell, :inline => "sudo yum install puppet -y"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.module_path = "modules"
    puppet.manifest_file = "default.pp"
    puppet.options = "--verbose --trace"
  end
  # config.vm.box_check_update = false
  # config.vm.network "forwarded_port", guest: 80, host: 8080
  # config.vm.network "private_network", ip: "192.168.33.10"
end
