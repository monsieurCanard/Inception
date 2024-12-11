#!/bin/sh

sleep 10

if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz

	cd /var/www/html/wordpress
	sed -i "s/username_here/${MY_WORDPRESS_DB_USER}/g" wp-config-sample.php
	sed -i "s/password_here/${MY_WORDPRESS_DB_PASSWORD}/g" wp-config-sample.php
	sed -i "s/localhost/${MY_WORDPRESS_DB_HOST}/g" wp-config-sample.php
	sed -i "s/database_name_here/${MY_WORDPRESS_DB}/g" wp-config-sample.php
	mv wp-config-sample.php wp-config.php

	/tmp/wp-cli.phar core install --url=${MY_WORDPRESS_URL} --title=${MY_WORDPRESS_TITLE} --admin_user=${MY_WORDPRESS_ADMIN_USER} --admin_password=${MY_WORDPRESS_ADMIN_PASSWORD} --admin_email=${MY_WORDPRESS_ADMIN_EMAIL} --allow-root

	/tmp/wp-cli.phar user create hen duckduck@example.com --user_pass=hen --allow-root
fi

exec "$@"