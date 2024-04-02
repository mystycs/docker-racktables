#!/bin/bash

# Initialize MariaDB data directory (only if it's not already initialized)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db
fi

# Start MariaDB
/etc/init.d/mysql start

# Set up secret.php file if it doesn't exist
SECRET_FILE='/var/www/racktables/wwwroot/inc/secret.php'
if [ ! -f "$SECRET_FILE" ]; then
    touch "$SECRET_FILE"
    chmod a=rw "$SECRET_FILE"
fi

# Install PHP extensions if not already installed
REQUIRED_EXTENSIONS="php-gd php-mysql php-mbstring php-bcmath php-json php-snmp"
for EXTENSION in $REQUIRED_EXTENSIONS; do
    if ! dpkg -l | grep -q "^ii  $EXTENSION"; then
        apt-get install -y $EXTENSION
    fi
done

# Start Apache2 in the foreground
exec apache2ctl -D FOREGROUND
