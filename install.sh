#!/bin/bash

# Update package list and upgrade installed packages
sudo apt-get update
sudo apt-get upgrade -y

# Install Nginx
sudo apt-get install nginx -y

# Install MariaDB
sudo apt-get install mariadb-server -y
sudo mysql_secure_installation

# Create a new database and user for WordPress
echo "CREATE DATABASE wordpress;
CREATE USER 'wpuser'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';
FLUSH PRIVILEGES;
EXIT" | sudo mysql -u root

# Install WordPress
sudo apt-get install wordpress -y
sudo ln -s /usr/share/wordpress /var/www/html/wordpress
sudo chown -R www-data:www-data /var/www/html/wordpress

# Update the WordPress config file with the new database information
sudo sed -i "s/database_name_here/wordpress/g" /etc/wordpress/config-localhost.php
sudo sed -i "s/username_here/wpuser/g" /etc/wordpress/config-localhost.php
sudo sed -i "s/password_here/password/g" /etc/wordpress/config-localhost.php
