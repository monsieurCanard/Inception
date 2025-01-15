#!/bin/bash

while [ ! -f /tmp/.secrets/.env ]; do
	echo "Waiting for secrets to be mounted";
	sleep 1;
done

set -a
. /tmp/.secrets/.env	
set +a


if grep -q "^$FTP_USER:" /etc/passwd; then
	echo "FTP user already exists";
else
	useradd -d /var/www/html $FTP_USER
	echo "$FTP_USER:$FTP_PASSWORD" | chpasswd
	echo "FTP user created";
fi

chmod -R 777 /var/www/html

echo "FTP server is ready";

exec "$@";


