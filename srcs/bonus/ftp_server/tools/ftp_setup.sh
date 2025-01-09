#!/bin/bash

echo "Starting FTP server";

echo "FTP_USER_FILE: $(cat $FTP_USER_FILE)";
echo "FTP_PASSWORD_FILE: $(cat $FTP_PASSWORD_FILE)";

if grep -q "^$(cat $FTP_USER_FILE):" /etc/passwd; then
	echo "FTP user already exists";
else
	useradd -d /var/www/html $(cat $FTP_PASSWORD_FILE)
	echo "$(cat $FTP_USER_FILE):$(cat $FTP_PASSWORD_FILE)" | chpasswd
fi

chmod -R 777 /var/www/html

# Start the FTP server
exec "$@";


