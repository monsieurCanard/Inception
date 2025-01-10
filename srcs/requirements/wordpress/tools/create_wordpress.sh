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

	sed -i "s/username_here/$(cat $WORDPRESS_DB_USER_FILE)/g" wp-config-sample.php
	sed -i "s/password_here/$(cat $WORDPRESS_DB_PASSWORD_FILE)/g" wp-config-sample.php
	sed -i "s/localhost/$(cat $WORDPRESS_DB_HOST_FILE)/g" wp-config-sample.php
	sed -i "s/database_name_here/$(cat $WORDPRESS_DB_NAME_FILE)/g" wp-config-sample.php

   	sed -i "1a\define('WP_REDIS_HOST', 'redis');" wp-config-sample.php
    sed -i "2a\define('WP_REDIS_PORT', 6379);" wp-config-sample.php
    sed -i "3a\define('WP_CACHE_KEY_SALT', 'antgabri.42.fr');" wp-config-sample.php
    sed -i "4a\define('WP_REDIS_DATABASE', 0);" wp-config-sample.php
    sed -i "5a\define('WP_CACHE', true);" wp-config-sample.php	
	
	mv wp-config-sample.php wp-config.php

	/tmp/wp-cli.phar core install --url=$(cat $WORDPRESS_URL_FILE) --title=$(cat $WORDPRESS_TITLE_FILE) --admin_user=$(cat $WORDPRESS_ADMIN_USER_FILE) --admin_password=$(cat $WORDPRESS_ADMIN_PASSWORD_FILE) --admin_email=$(cat $WORDPRESS_ADMIN_EMAIL_FILE) --allow-root

	/tmp/wp-cli.phar user create hen duckduck@example.com --user_pass=hen --allow-root

	/tmp/wp-cli.phar plugin install redis-cache --activate --allow-root
		
	/tmp/wp-cli.phar redis enable --allow-root
fi

echo "Copying website files"
mkdir -p /var/www/html/static_site
cp -r /tmp/www/* /var/www/html/static_site/

exec "$@"