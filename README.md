# RackTables Docker Build 0.22.0

This Docker build provides an updated environment for RackTables, a datacenter and server room asset management solution, with dependencies updated for 2024.

## Building the Docker Image

To build the Docker image, navigate to the directory containing the `Dockerfile` and run the following command:

```bash
docker build -t racktables:latest .
```

This will create a Docker image tagged as `racktables:latest`.

## Running the Docker Container

To run the Docker container, use the following command:

```bash
docker build -t racktables:latest .
docker run -d -p 80:80 --name racktables racktables:latest
```

This will start the RackTables container and map port 80 of the container to port 80 of the host.

## Accessing RackTables

Once the container is running, you can access RackTables installer by navigating to:

```
http://localhost/index.php?module=installer
```

Follow the on-screen instructions to complete the installation process.

## Setting Up the Database Schema

During the installation process, you will need to set up the database schema. In step 3 of the installation process, use the following commands to create the database and user:

```bash
docker exec -it racktables mysql -uroot -p -e "CREATE DATABASE racktables_db CHARACTER SET utf8 COLLATE utf8_general_ci; CREATE USER 'racktables_user'@'localhost' IDENTIFIED BY 'MY_SECRET_PASSWORD'; GRANT ALL PRIVILEGES ON racktables_db.* TO 'racktables_user'@'localhost';"

```

Replace `MY_SECRET_PASSWORD` with the password you choose.

## Finalizing the Installation

In step 4 of the installer, you will need to set the correct permissions for the `secret.php` file. You can do this by executing the following command on the Docker container:

```bash
docker exec racktables chown www-data:nogroup /var/www/racktables/wwwroot/inc/secret.php; chmod 440 /var/www/racktables/wwwroot/inc/secret.php
```

Once you have completed these steps, RackTables should be installed and ready to use. Complete the instructions on screen.

For more information about RackTables, visit the [official website](https://www.racktables.org/).


Feel free to adjust the content as needed for your specific Docker build and RackTables setup.
