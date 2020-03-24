# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION="2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  ########################################################
  # Section 1 : Common Settings
  ########################################################
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
  end

  ########################################################
  # Section 2 : Machine Settings
  ########################################################
  # Development Server
  config.vm.define :develop do |develop|
    # Base Box
    develop.vm.box = "bento/ubuntu-16.04"
    # SSH Key
    develop.ssh.insert_key = false
    # Network Configuration
    develop.vm.network "private_network", ip: "192.168.33.10"
    # Sync Folder Configuration
    develop.vm.synced_folder "./app",
                            "/var/www/app",
                            id: 'vagrant-root',
                            nfs: false,
                            owner: 'vagrant',
                            group: 'vagrant',
                            mount_options: ['dmode=777', 'fmode=777']
  end

  ########################################################
  # Section 3 : Provisioning
  ########################################################
  config.vm.provision "ansible_local" do |ansible|
    ansible.playbook = "provisioning/site.yml"
    ansible.groups = {
      "devservers" => ["develop"]
    }
  end
end
