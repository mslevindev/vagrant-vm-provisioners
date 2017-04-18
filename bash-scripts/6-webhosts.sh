#!/usr/bin/env bash

echo 'Setting up Active VHOSTS ..........................................'

active_vhosts=$1
disabled_vhosts=$2

# Create the www folder.
if [ ! -d "/var/www" ]; then
  sudo mkdir /var/www
fi

# Loop through all vhosts and create a new directory and matching .conf files.
IFS=' ' read -ra ACTIVEVHOSTS <<< "$active_vhosts" # Set delimiter to a comma, and convert string to array.
for VHOSTNAME in "${ACTIVEVHOSTS[@]}"; do

    echo "Create new directory and VHOST for $VHOSTNAME"
    sudo mkdir -p /var/www/$VHOSTNAME
    sudo cp /etc/apache2/sites-available/default /etc/apache2/sites-available/$VHOSTNAME.conf
    sudo sed -i s,default.local,$VHOSTNAME,g /etc/apache2/sites-available/$VHOSTNAME.conf
    sudo sed -i s,/var/www,/var/www/$VHOSTNAME,g /etc/apache2/sites-available/$VHOSTNAME.conf
    sudo a2ensite $VHOSTNAME.conf

done

# Restart Apache.
sudo service apache2 reload > /dev/null 2>&1

echo 'Active VHOSTS set up Complete #'
echo ' ';
echo 'Setting up Disabled VHOSTS ..........................................'

# Loop through all disabled_vhosts and disable them.
IFS=' ' read -ra DISABLEDVHOSTS <<< "$disabled_vhosts" # Set delimiter to a comma, and convert string to array.
for DISABLEDVHOSTNAME in "${DISABLEDVHOSTS[@]}"; do

    echo "Disable $DISABLEDVHOSTNAME"
    sudo a2dissite $DISABLEDVHOSTNAME.conf

done

# Restart Apache.
sudo service apache2 reload > /dev/null 2>&1

echo 'Disabled VHOSTS set up Complete #'
echo ' ';
echo ' ';
