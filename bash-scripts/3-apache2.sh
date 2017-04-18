#!/bin/bash

echo '# Installing Apache2 Packages..........................................'

server_name=$1

# Add the Apache2 PPA.
sudo add-apt-repository -y ppa:ondrej/apache2 > /dev/null 2>&1
sudo apt-key -qq update > /dev/null 2>&1
sudo apt-get -qq update

# Install Apache2.
sudo apt-get install -y apache2 > /dev/null 2>&1

# Update ownership of Apache.
APACHEUSR=`grep -c 'APACHE_RUN_USER=www-data' /etc/apache2/envvars`
APACHEGRP=`grep -c 'APACHE_RUN_GROUP=www-data' /etc/apache2/envvars`
if [ APACHEUSR ];
then
    sudo sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=vagrant/' /etc/apache2/envvars
fi
if [ APACHEGRP ];
then
    sudo sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=vagrant/' /etc/apache2/envvars
fi

# Allow Vagrant to Update the apache2 lock file #
sudo chown -R vagrant:www-data /var/lock/apache2

# Enable modules #
sudo a2enmod rewrite > /dev/null 2>&1

# Replace `default` vhost file so we can copy it for new VHOSTS.
    cat > '/etc/apache2/sites-available/default' << EOF
<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        ServerName default.local
        ServerAlias www.default.local
        DocumentRoot /var/www
        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
        <FilesMatch \.php$>
                SetHandler "proxy:fcgi://127.0.0.1:9000"
        </FilesMatch>
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet

EOF

# Turn on PHP errors.
#sudo sed -i "s/error_reporting = .*/error_reporting = E_ALL/" /etc/php5/apache2/php.ini # Optional
#sudo sed -i "s/display_errors = .*/display_errors = On/" /etc/php5/apache2/php.ini # Optional

# Restart Apache.
sudo service apache2 restart > /dev/null 2>&1

echo 'Apache2 Installed #'
echo ' ';
echo ' ';