#!/bin/sh

echo "wp db name: $WP_DB_NAME"
echo "wp db usr: $WP_DB_USR"
echo "wp db usr: $WP_DB_PWD"
echo "db host: $MARIADB_HOST"

while ! mariadb -h$MARIADB_HOST -u$WP_DB_USR -p$WP_DB_PWD $WP_DB_NAME &>/dev/null; do
	sleep 3
    echo " waiting for database..."
done

if [ -f ./wp-config.php ]
then
	echo "wordpress already downloaded"
else

	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf latest.tar.gz
	rm -rf wordpress

	sed -i "s/username_here/$WP_DB_USR/g" wp-config-sample.php
	sed -i "s/password_here/$WP_DB_PWD/g" wp-config-sample.php
	sed -i "s/localhost/$MARIADB_HOST/g" wp-config-sample.php
	sed -i "s/database_name_here/$WP_DB_NAME/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

    wp core install --url=$DOMAIN_NAME --title="Inception 42" --admin_user=$WP_ADMIN_USR --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
    wp user create $WP_USR $WP_EMAIL --role=author --user_pass=$WP_PWD --allow-root
	wp theme install twentytwentythree --activate --allow-root

fi

php-fpm8 -F -R
