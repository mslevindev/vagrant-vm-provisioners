#!/bin/bash

php_version=$1

echo '# Removing Previous Installation of PHP ..........................................'

# Remove Previous PHP #
sudo apt-get -y purge `dpkg -l | grep php| awk '{print $2}' |tr "\n" " "` > /dev/null 2>&1
sudo rm -fR /etc/php/*
sudo rm -fR /var/lib/php
sudo rm -fR /etc/apt/sources.list.d/ondrej-php-trusty.*
sudo rm -fR /etc/apt/trusted.gpg.d/ondrej-php.*
sudo apt-get clean
echo '# PHP Removed.'
echo ' ';
echo ' ';

if [ $php_version ];
then

    echo '# Installing PHP '"$php_version"'..........................................'

    sudo add-apt-repository ppa:ondrej/php > /dev/null 2>&1
    sudo apt-key -qq update > /dev/null 2>&1

    # Update APT packages.
    sudo apt-get -qq update > /dev/null 2>&1

    # A specific version
    sudo apt-get -y install php"$php_version" > /dev/null 2>&1
    sudo apt-get -y install php"$php_version"-cli php"$php_version"-mysqlnd > /dev/null 2>&1
    sudo apt-get -y install php"$php_version" php"$php_version"-curl php"$php_version"-gd php"$php_version"-intl php-pear > /dev/null 2>&1
    sudo apt-get -y install php"$php_version"-imagick php"$php_version"-imap php"$php_version"-mcrypt > /dev/null 2>&1
    sudo apt-get -y install php"$php_version"-memcache memcached php"$php_version"-pspell > /dev/null 2>&1
    sudo apt-get -y install php"$php_version"-recode php"$php_version"-sqlite3 php"$php_version"-tidy > /dev/null 2>&1
    sudo apt-get -y install php"$php_version"-xmlrpc php"$php_version"-xsl php"$php_version"-mbstring > /dev/null 2>&1
    sudo apt-get -y install php"$php_version"-zip php"$php_version"-gettext php"$php_version"-soap php"$php_version"-xdebug > /dev/null 2>&1

else

    echo '# Installing the latest version of PHP ..........................................'

    sudo add-apt-repository ppa:ondrej/php > /dev/null 2>&1
    sudo apt-key -qq update > /dev/null 2>&1

    # Update APT packages.
    sudo apt-get -qq update > /dev/null 2>&1

    sudo apt-get -y install php > /dev/null 2>&1
    sudo apt-get -y install php-cli php-mysqlnd > /dev/null 2>&1
    sudo apt-get -y install php-curl php-gd php-intl php-pear > /dev/null 2>&1
    sudo apt-get -y install php-imagick php-imap php-mcrypt > /dev/null 2>&1
    sudo apt-get -y install php-memcache memcached php-pspell > /dev/null 2>&1
    sudo apt-get -y install php-recode php-sqlite3 php-tidy > /dev/null 2>&1
    sudo apt-get -y install php-xmlrpc php-xsl php-mbstring > /dev/null 2>&1
    sudo apt-get -y install php-zip php-gettext php-soap php-xdebug > /dev/null 2>&1

fi

# Fix any dependency issues.
sudo apt-get -fy install > /dev/null 2>&1

# Update APT packages.
sudo apt-get -qq update > /dev/null 2>&1
sudo apt-get -y autoremove

sudo phpenmod curl ssl > /dev/null 2>&1

echo 'PHP Installed'
echo ' ';
echo ' ';
