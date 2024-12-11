#!bin/sh

echo "mot de passe est $MYSQL_ROOT_PASSWORD";
echo "mot de passe est $MYSQL_PASSWORD";
echo "mot de passe est $MYSQL_USER";
echo "mot de passe est $WORDPRESS_DB_NAME";


/etc/init.d/mariadb start;

# while [ ! -e /var/run/mysqld/mysqld.sock ]; do
#     echo "Waiting for MariaDB to start..."
#     sleep 5
# done

mysql_secure_installation << END

Y
$MYSQL_ROOT_PASSWORD
$MYSQL_ROOT_PASSWORD
Y
Y
Y
Y
END


#create DB    
mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ${WORDPRESS_DB_NAME};"

mysql -uroot -p$MYSQL_ROOT_PASSWORD -e  "grant all on *.* to 'root'@'%' identified by '${MYSQL_ROOT_PASSWORD}';FLUSH PRIVILEGES;";

mysql -uroot -p$MYSQL_ROOT_PASSWORD -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; GRANT ALL PRIVILEGES ON ${WORDPRESS_DB_NAME}.* TO '${MYSQL_USER}'@'%'; FLUSH 
PRIVILEGES;";


/etc/init.d/mariadb stop;


exec "$@";