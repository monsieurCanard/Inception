#!/bin/bash
# Attendre que le service MySQL soit prêt
# Cela permet de s'assurer que MariaDB est bien lancé avant d'exécuter les scripts d'initialisation
rm -rf /var/lib/mysql/aria_log_control

mysqld_safe  &
MARIADB_PID=$!

# Attendre quelques secondes pour que MariaDB démarre
echo "Waiting for MariaDB to start..."
sleep 10  # 10 secondes pour laisser MariaDB démarrer (ajustez si nécessaire)

# Vérifier que MariaDB est bien démarré
until mysql -u root -e "SHOW DATABASES;" &>/dev/null; do
  echo "Waiting for MariaDB to be ready..."
  sleep 1
done
# Lancer MariaDB en arrière-plan
echo "Creating database if not exists..."
mysql -u root -e "CREATE DATABASE IF NOT EXISTS my_database;"

# Créer un utilisateur et lui donner des privilèges si nécessaire
echo "Creating user and granting privileges..."
mysql -u root -e "CREATE USER IF NOT EXISTS 'my_user'@'%' IDENTIFIED BY 'my_password';"
mysql -u root -e "GRANT ALL PRIVILEGES ON my_database.* TO 'my_user'@'%';"
mysql -u root -e "FLUSH PRIVILEGES;"

echo "Running additional initialization tasks..."
mysql -u root my_database < /docker-entrypoint-initdb.d/init.sql

# Lancer MariaDB comme processus principal
exec mysqld