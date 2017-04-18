#!/bin/bash

echo '# Installing Essential Packages ..........................................'

# Update APT packages.
sudo apt-get -qq update

# Clear apt caches.
sudo apt-get clean

# Install packages.
sudo apt-get -y install nfs-common mysql-common build-essential libhtml-template-perl > /dev/null 2>&1
sudo apt-get -y install python-software-properties vsftpd unzip make openssl imagemagick unoconv > /dev/null 2>&1
sudo apt-get -y install debconf-utils  > /dev/null 2>&1

# Update APT packages.
sudo apt-get -qq update

# Fix any dependency issues.
sudo apt-get -fy install > /dev/null 2>&1

echo 'Essential Packages Installed'
echo ' ';
echo ' ';
