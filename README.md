# vagrant-vm-provisioners
Provisioner framework for building Vagrant VMs

NOTE: This is intended for local development only and should not be used on a production server!

The folders builds a basic structure for a LAMP server containing a Vagrantfile which loads a series of bash scripts. 
It incorporates ideas from vaprobash and others, but also autogenerates VHOSTS and databases to minimise setup pains. 
Edit the Vagrantfile to configure your server.

It's up to date with PHP 7.1 but it should also support newer php versions as they are released. 

Be aware that it is a work-in-progress:
1. There is no support for HHVM yet.
2. I need to fix the hostname and vhost site names on the server to enable mail sending.
3. Disabling VHOSTs is experimental.
4. I'd like to add postgresql support.

Any constructive feedback or suggestions are welcome. 
