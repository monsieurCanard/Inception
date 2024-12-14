#!/bin/bash

echo "Starting FTP server";

if grep -q "^$(cat $FTP_USER_FILE)):" /etc/passwd; then
	echo "FTP user already exists";
else
	useradd -d /var/www/html $(cat $FTP_PASSWORD_FILE))
	echo "duck:duck4life" | chpasswd
fi

chmod -R 777 /var/www/html

# Start the FTP server
exec "$@";


