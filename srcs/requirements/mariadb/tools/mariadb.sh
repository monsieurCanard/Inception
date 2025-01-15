#!/bin/sh

/etc/init.d/mariadb start;

set -a
. /tmp/.secrets/.env
set +a

DB_ALREADY_EXISTS=$(mysql -uroot -p$ROOT_PASSWORD -e "SHOW DATABASES" | grep $SQL_DB_NAME | wc -l);

if [ $DB_ALREADY_EXISTS -eq 1 ]; then
	echo "Database already exists";
else
	echo "Database does not exist";
	mysql_secure_installation << END
Y
$ROOT_PASSWORD
$ROOT_PASSWORD
Y
Y
Y
Y
END


mysql -uroot -p$ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS $SQL_DB_NAME;"

mysql -uroot -p$ROOT_PASSWORD -e "CREATE USER '$SQL_USER'@'%' IDENTIFIED BY '$PASSWORD'; GRANT ALL PRIVILEGES ON $SQL_DB_NAME.* TO '$SQL_USER'@'%'; FLUSH 
PRIVILEGES;";

fi

sleep 1;

/etc/init.d/mariadb stop;

exec "$@";