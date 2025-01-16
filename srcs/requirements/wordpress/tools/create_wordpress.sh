#!/bin/sh


if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
	sleep 5
	rm /tmp/.secrets/.env

else
	echo "Downloading wordpress"
	
	set -a
	. /tmp/.secrets/.env
	set +a

	while ! nc -z $WP_DB_NAME 3306; do
		echo "Waiting for mariadb to be up";
		sleep 1;
	done

	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz

	cd /var/www/html/wordpress

	sed -i "s/username_here/$WP_USER/g" wp-config-sample.php
	sed -i "s/password_here/$PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$WP_DB_HOST/g" wp-config-sample.php
	sed -i "s/database_name_here/$WP_DB_NAME/g" wp-config-sample.php

   	sed -i "1a\define('WP_REDIS_HOST', '${REDIS_HOST}');" wp-config-sample.php
    sed -i "2a\define('WP_REDIS_PORT', 6379);" wp-config-sample.php
    sed -i "3a\define('WP_CACHE_KEY_SALT', '${WP_URL}');" wp-config-sample.php
    sed -i "4a\define('WP_REDIS_DATABASE', 0);" wp-config-sample.php
    sed -i "5a\define('WP_CACHE', true);" wp-config-sample.php
	
	mv wp-config-sample.php wp-config.php

	/tmp/wp-cli.phar core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_MAIL --allow-root

	/tmp/wp-cli.phar user create $WP_USER2 $USER2_MAIL --user_pass=$USER2_PASS --allow-root

	/tmp/wp-cli.phar plugin install redis-cache --activate --allow-root
		
	/tmp/wp-cli.phar redis enable --allow-root

	chown -R www-data:www-data /var/www/html/wordpress
	rm /tmp/.secrets/.env
fi

# mkdir -p /var/www/html/static_site

# echo "Copying website files"
# cp -r /tmp/www/* /var/www/html/static_site/


exec "$@"