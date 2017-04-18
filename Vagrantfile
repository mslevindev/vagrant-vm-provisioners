# -*- mode: ruby -*-
# vi: set ft=ruby :

# Unique server name - Restrict to alpha numeric characters only
server_name = "php56-20170419.com" # Always include a .com suffix in your server name.

# Indicate your preferred local vhost subdomain prefix - Optional.
# i.e. If your domain is site001.com you could use the prefix 'local' to access it at local.site001.com.
prefix="" # Default is set to empty.
#prefix="local" # Example of a dev subdomain prefix.

# Assign a list of vhosts to create on this Vagrant Box.
# Virtual hosts MUST end with a trailing empty space character. e.g. "local.site001.com "
active_vhosts="local.site001.com "
#active_vhosts+="local.site002.com " # Example of a second website.

# TODO - Experiemental
disabled_vhosts=""

# The database root user password.
db_root_password = "root"

# PHP Version: 5.6, 7.1, 7.2, etc. #
php_version = "" # Default is set to empty to install latest php version.
#php_version = "5.6" # Example of a specific version

Vagrant.configure(2) do |config|

  # Box details
  config.vm.box = "ubuntu/trusty64"
  config.vm.hostname = server_name

  # Networking: port forwarding and private network
  config.vm.network "private_network", ip: "192.168.25.112"
  config.vm.network :forwarded_port, guest: 80, host: 8016, auto_correct: true

  # For Windows users only: Uncomment to Enable winnfsd NFS plugin.
  #config.winnfsd.uid = 1
  #config.winnfsd.gid = 1
  # For Windows users only: Uncomment to add a private dhcp network.
  #config.vm.network "private_network", type: "dhcp"
  # For Windows users only: You MUST install the vagrant plugin: vagrant-winnfsd
  # Run this command once: vagrant plugin install vagrant-winnfsd

  # Set some VM options
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", 1024]
    vb.customize ["modifyvm", :id, "--cpus", 2]
  end

  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.provision "shell", path: "./bash-scripts/1-essentials.sh"
  config.vm.provision "shell", path: "./bash-scripts/2-php.sh", args: [php_version]
  config.vm.provision "shell", path: "./bash-scripts/3-apache2.sh", args: [server_name]
  config.vm.provision "shell", path: "./bash-scripts/4-mysql.sh", args: [db_root_password]
  config.vm.provision "shell", path: "./bash-scripts/5-databases.sh", args: [active_vhosts, db_root_password, prefix]
  config.vm.provision "shell", path: "./bash-scripts/6-webhosts.sh", args: [active_vhosts, disabled_vhosts]

  # Set up the sync'ed folders
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.synced_folder "./www", "/var/www",
    id: "web-root",
    nfs: true,
    version: 3

  # Use hostmanager plugin to update both the host and guest hosts files
  # Run this command once: vagrant plugin install vagrant-hostmanager
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true
  config.hostmanager.aliases = active_vhosts

  # hostmanager provisioner
  config.vm.provision :hostmanager

end
