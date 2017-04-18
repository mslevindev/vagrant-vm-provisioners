#!/bin/bash

active_vhosts=$1
db_root_password=$2
prefix=$3

echo '# Configure MySQL Databases..........................................'

# Loop through all vhosts and create a new database for each one.
IFS=' ' read -ra VHOSTS <<< "$active_vhosts" # Set delimiter to a space, and convert string to array.
for VHOST in "${VHOSTS[@]}"; do

    if [ $prefix ];
    then
        DBNAME=${VHOST//$prefix\./} # Get rid of prefix subdomain.
    else
        DBNAME=$VHOST
    fi
    DBNAME=${DBNAME//[-.]/_} # Set current DB Name, replacing dashes (-) with underscores (_).

    mysql -uroot -p$db_root_password -e "CREATE DATABASE $DBNAME DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
    mysql -uroot -p$db_root_password -e "GRANT ALL ON $DBNAME.* TO devuser@localhost IDENTIFIED BY '1234';"
    mysql -uroot -p$db_root_password -e "FLUSH PRIVILEGES;"

done

# Restart MySQL.
sudo service mysql restart > /dev/null 2>&1

echo '# MySQL Databases Installed #'
echo ' ';
echo ' ';