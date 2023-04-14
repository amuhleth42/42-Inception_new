#!/bin/bash

service mysql start;
mysql -u root -e "CREATE USER '$WP_DB_USR'@'%' IDENTIFIED BY '$WP_DB_PWD';"
mysql -u root -e "CREATE DATABASE $WP_DB_NAME;"
mysql -u root -e "USE $WP_DB_NAME; GRANT ALL PRIVILEGES ON * TO '$WP_DB_USR'@'%' WITH GRANT OPTION; FLUSH PRIVILEGES;"
#mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MARIADB_ROOT_PWD';"

echo "mariadb started !"
