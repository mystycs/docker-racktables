#!/bin/bash

# Initialize MariaDB data directory (only if it's not already initialized)
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mysql_install_db
fi

# Start MariaDB
/etc/init.d/mysql start

# Secure the MariaDB installation (you can add your own settings here)
# Note: For production use, it's recommended to set a strong root password and adjust other security settings.
mysql_secure_installation <<EOF

y
$MARIADB_ROOT_PASSWORD
$MARIADB_ROOT_PASSWORD
y
y
y
y
EOF

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
