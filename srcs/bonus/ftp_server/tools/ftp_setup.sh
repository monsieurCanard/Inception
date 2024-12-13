#!/bin/bash

echo "Starting FTP server";

if grep -q "^duck:" /etc/passwd; then
	echo "User ducsekfjslkefjslkefjk already exists";
else
	useradd -d /var/www/html duck
	echo "duck:duck4life" | chpasswd
fi

chmod -R 777 /var/www/html

# Start the FTP server
exec "$@";


