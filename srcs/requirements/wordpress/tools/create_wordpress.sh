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
	sed -i "s/username_here/${WORDPRESS_DB_USER}/g" wp-config-sample.php
	sed -i "s/password_here/${WORDPRESS_DB_PASSWORD}/g" wp-config-sample.php
	sed -i "s/localhost/${WORDPRESS_DB_HOST}/g" wp-config-sample.php
	sed -i "s/database_name_here/${WORDPRESS_DB_NAME}/g" wp-config-sample.php
	mv wp-config-sample.php wp-config.php
fi

exec "$@"