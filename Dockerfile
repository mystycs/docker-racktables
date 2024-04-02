FROM ubuntu:20.04

# Install dependencies
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    apache2-bin \
    libapache2-mod-php \
    mariadb-server \
    wget \
    unzip \
    && apt-get clean

# Download RackTables
RUN wget https://sourceforge.net/projects/racktables/files/latest/download -O /tmp/racktables-latest.zip

# Unzip
RUN unzip /tmp/racktables-latest.zip -d /var/www/ && \
    mv /var/www/RackTables-* /var/www/racktables && \
    chown -R www-data:www-data /var/www/racktables

# Configure Apache
RUN sed -i 's|/var/www/html|/var/www/racktables/wwwroot|g' /etc/apache2/sites-available/000-default.conf
RUN sed -i 's|/var/www/html|/var/www/racktables/wwwroot|g' /etc/apache2/sites-enabled/000-default.conf
RUN sed -i 's|/var/www|/var/www/racktables/wwwroot|g' /etc/apache2/apache2.conf

# Expose port 80
EXPOSE 80

# Copy entrypoint script and set permissions
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]
