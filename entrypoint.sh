#!/bin/bash

# Initialize MariaDB data directory (only if it's not already initialized)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db
fi

# Start MariaDB
/etc/init.d/mysql start

#Set up secret.php file
touch '/var/www/racktables/wwwroot/inc/secret.php'

chmod a=rw '/var/www/racktables/wwwroot/inc/secret.php'

# Install PHP extensions
apt-get update && apt-get install -y \
    php-gd php-mysql \
    php-mbstring php-bcmath php-json php-snmp \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Start Apache2 in the foreground
exec apache2ctl -D FOREGROUND
