#!/bin/bash

db_root_password=$1

echo '# Install and Configure MySQL..........................................'

# Install MySQL Server #
sudo apt-get install -y mysql-server > /dev/null 2>&1

# Update APT packages #
sudo apt-get -qq update

# Update Binding
sudo sed -i "s/bind-address.*/bind-address = 0.0.0.0/" /etc/mysql/my.cnf

# Update mysql to use separate database  files
echo "innodb_file_per_table = 1" >> /etc/mysql/my.cnf
echo "innodb_file_format = Barracuda" >> /etc/mysql/my.cnf


# Configure MySQL root user..........................................#
echo "mysql-server mysql-server/root_password password $db_root_password" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password $db_root_password" | debconf-set-selections
mysql -uroot -p$db_root_password -e "SHOW DATABASES;" > /dev/null 2>&1
if [[ $? -gt 0 ]]
then
    echo "Root pass not set!"
fi

# Restart MySQL.
sudo service mysql restart > /dev/null 2>&1

echo '# MySQL Installed #'
echo ' ';
echo ' ';