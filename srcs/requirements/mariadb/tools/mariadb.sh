#!bin/sh

echo "Starting MariaDB";

/etc/init.d/mariadb start;

export MY_SQL_PASSWORD=$(cat $MY_SQL_PASSWORD_FILE);
export MY_SQL_ROOT_PASSWORD=$(cat $MY_SQL_ROOT_PASSWORD_FILE);
export MY_SQL_USER=$(cat $MY_SQL_USER_FILE);
export DB_NAME=$(cat $DB_NAME_FILE);

echo "Sql root password: $MY_SQL_ROOT_PASSWORD";
echo "Sql user: $MY_SQL_USER";
echo "Sql password: $MY_SQL_PASSWORD";
echo "Database name: $DB_NAME";


DB_ALREADY_EXISTS=$(mysql -uroot -p$MY_SQL_ROOT_PASSWORD -e "SHOW DATABASES" | grep ${MY_WORDPRESS_DB} | wc -l);

if [ $DB_ALREADY_EXISTS -eq 1 ]; then
	echo "Database already exists";
else
	echo "Database does not exist";
	mysql_secure_installation << END

Y
$MY_SQL_ROOT_PASSWORD
$MY_SQL_ROOT_PASSWORD
Y
Y
Y
Y
END


	mysql -uroot -p$MY_SQL_ROOT_PASSWORD -e "CREATE DATABASE IF NOT EXISTS ${DB_NAME};"

	mysql -uroot -p$MY_SQL_ROOT_PASSWORD -e  "grant all on *.* to 'root'@'%' identified by '${MY_SQL_ROOT_PASSWORD}';FLUSH PRIVILEGES;";

	mysql -uroot -p$MY_SQL_ROOT_PASSWORD -e "CREATE USER '${MY_SQL_USER}'@'%' IDENTIFIED BY '${MY_SQL_PASSWORD}'; GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${MY_SQL_USER}'@'%'; FLUSH 
	PRIVILEGES;";

fi

/etc/init.d/mariadb stop;


exec "$@";