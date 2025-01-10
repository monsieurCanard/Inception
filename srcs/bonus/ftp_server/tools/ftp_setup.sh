#!/bin/bash

echo "Starting FTP server";

if grep -q "^$(cat $FTP_USER):" /etc/passwd; then
	echo "FTP user already exists";
else
	useradd -d /var/www/html $(cat $FTP_USER)
	echo "$(cat $FTP_USER):$(cat $FTP_PASSWORD)" | chpasswd
fi

chmod -R 777 /var/www/html

# Start the FTP server
exec "$@";


