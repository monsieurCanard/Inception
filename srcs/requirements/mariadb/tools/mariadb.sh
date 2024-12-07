#!/bin/sh

# Initialiser les tables système de MariaDB
mysql_install_db --user=mysql --ldata=/var/lib/mysql

# Démarrer MariaDB en arrière-plan
mysqld --datadir='/var/lib/mysql' --user=mysql &

# Attendre que MariaDB soit bien lancé et que le socket soit disponible
while [ ! -e /var/run/mysqld/mysqld.sock ]; do
    echo "Waiting for MariaDB to start..."
    sleep 5
done

# Attente supplémentaire pour garantir que MariaDB est totalement prêt
echo "MariaDB started"

# Vérifier si la base de données existe déjà
if [ -d "/var/lib/mysql/mariadb" ]; then 
    echo "Database already exists"
else
    echo "Creating database"

    # Initialiser le mot de passe root en se connectant à MariaDB
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "UPDATE mysql.user SET Password=PASSWORD('${MYSQL_ROOT_PASSWORD}') WHERE User='root';"
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.user WHERE User='';"
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "DROP DATABASE IF EXISTS test;"
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "DELETE FROM mysql.db WHERE Db='test' OR Db='test\\_%';"
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "FLUSH PRIVILEGES;"

    # Add a root user on 127.0.0.1 to allow remote connection 
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"

    # Create database and user in the database for WordPress
    mysql -uroot -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE}; GRANT ALL ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; FLUSH PRIVILEGES;"

    echo "Database created and configured"
fi

# Arrêter MariaDB proprement
mysqladmin -uroot -p${MYSQL_ROOT_PASSWORD} shutdown

echo "Database is ready"

exec "$@"
