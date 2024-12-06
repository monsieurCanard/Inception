FROM debian:buster

# Installer MariaDB
RUN apt-get update && apt-get install -y mariadb-server

# Créer le répertoire pour les fichiers de données et définir les permissions
RUN mkdir -p /var/run/mysqld && \
	mkdir -p /var/lib/mysql && \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld

# Expose le port 3306 pour la base de données
EXPOSE 3306

# Copier la configuration et le script d'initialisation
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/
COPY ./tools/init.sql /docker-entrypoint-initdb.d/

COPY ./tools/entrypoint.sh /entrypoint.sh

# Donner les droits d'exécution
RUN chmod +x /entrypoint.sh

# Utiliser notre script personnalisé comme entrypoint
ENTRYPOINT ["/entrypoint.sh"]
# Commande d'entrée par défaut pour démarrer MariaDB
CMD ["mysqld"]
