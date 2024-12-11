#!bin/sh


/etc/init.d/mariadb start;

mysql_secure_installation << END

Y
$MY_SQL_ROOT_PASSWORD
$MY_SQL_ROOT_PASSWORD
Y
Y
Y
Y
END


#create DB    
mysql -uroot -p$MY_SQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ${MY_WORDPRESS_DB};"

mysql -uroot -p$MY_SQL_ROOT_PASSWORD -e  "grant all on *.* to 'root'@'%' identified by '${MY_SQL_ROOT_PASSWORD}';FLUSH PRIVILEGES;";

mysql -uroot -p$MY_SQL_ROOT_PASSWORD -e "CREATE USER '${MY_SQL_USER}'@'%' IDENTIFIED BY '${MY_SQL_PASSWORD}'; GRANT ALL PRIVILEGES ON ${MY_WORDPRESS_DB}.* TO '${MY_SQL_USER}'@'%'; FLUSH 
PRIVILEGES;";


/etc/init.d/mariadb stop;


exec "$@";