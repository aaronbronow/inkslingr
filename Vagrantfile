# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "boxcutter/centos64"
  config.ssh.forward_agent = true
  
  # Set timezone
  timezone = 'America/Los_Angeles'
  config.vm.provision :shell, inline: "sudo rm /etc/localtime; sudo ln -s /usr/share/zoneinfo/#{timezone} /etc/localtime"
  
  config.vm.provision :shell, path: "vagrant/yum-install.sh"
  config.vm.provision :shell, path: "vagrant/install-rvm.sh", args: "stable", privileged: false
  config.vm.provision :shell, path: "vagrant/install-ruby.sh", args: "2.2.1", privileged: false
  
  # Configure profile
  config.vm.provision :shell, privileged: false do |s|
    s.inline = "echo 'export RAILS_ENV=development' >> ~/.bash_profile;
                echo 'cd /vagrant' >> ~/.bash_profile;
                source ~/.bash_profile"
  end
  
  # Always start postgresql
  config.vm.provision :shell, inline: "service postgresql-9.2 start", run: "always"
  
  # Install gems and configure app
  config.vm.provision :shell, path: "vagrant/install-app.sh", privileged: false

  # Forward rails server and postgres ports
  config.vm.network "forwarded_port", guest: 3000, host: 8080
  config.vm.network "forwarded_port", guest: 5432, host: 5435
end
