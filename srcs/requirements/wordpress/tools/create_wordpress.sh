#!/bin/sh

if [ -f ./wordpress/wp-config.php ]
then
	echo "wordpress already downloaded"
else
	#Download wordpress
	wget https://wordpress.org/latest.tar.gz
	tar -xzvf latest.tar.gz
	rm -rf latest.tar.gz


	#Inport env variables in the config file
	cd /var/www/html/wordpress
	sed -i "s/username_here/antgabri/g" wp-config-sample.php
	sed -i "s/password_here/12345/g" wp-config-sample.php
	sed -i "s/localhost/mariadb:3306/g" wp-config-sample.php
	sed -i "s/database_name_here/wordpress/g" wp-config-sample.php
	mv wp-config-sample.php wp-config.php
fi

exec "$@"