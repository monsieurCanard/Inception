#!/bin/sh

# sleep 10

while [ ! -f /tmp/.secrets/.env ]; do
	echo "Waiting for secrets to be mounted";
	sleep 1;
done

set -a
. /tmp/.secrets/.env
set +a

cat /tmp/.secrets/.env

echo "WP_USER: $WP_USER";
echo "PASSWORD: $PASSWORD";
echo "WP_DB_HOST: $WP_DB_HOST";
echo "WP_DB_NAME: $WP_DB_NAME";


if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz

	cd /var/www/html/wordpress

	sed -i "s/username_here/$WP_USER/g" wp-config-sample.php
	sed -i "s/password_here/$PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$WP_DB_HOST/g" wp-config-sample.php
	sed -i "s/database_name_here/$WP_DB_NAME/g" wp-config-sample.php

   	sed -i "1a\define('WP_REDIS_HOST', 'redis');" wp-config-sample.php
    sed -i "2a\define('WP_REDIS_PORT', 6379);" wp-config-sample.php
    sed -i "3a\define('WP_CACHE_KEY_SALT', 'antgabri.42.fr');" wp-config-sample.php
    sed -i "4a\define('WP_REDIS_DATABASE', 0);" wp-config-sample.php
    sed -i "5a\define('WP_CACHE', true);" wp-config-sample.php	
	
	mv wp-config-sample.php wp-config.php

	/tmp/wp-cli.phar core install --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_MAIL --allow-root

	/tmp/wp-cli.phar user create hen duckduck@example.com --user_pass=hen --allow-root

	/tmp/wp-cli.phar plugin install redis-cache --activate --allow-root
		
	/tmp/wp-cli.phar redis enable --allow-root
fi

echo "Copying website files"
mkdir -p /var/www/html/static_site
cp -r /tmp/www/* /var/www/html/static_site/

exec "$@"