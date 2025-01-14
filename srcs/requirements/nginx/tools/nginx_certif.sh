#!/bin/bash

while [ ! -f /tmp/.secrets/.env ]; do
	echo "Waiting for doppler secrets to be mounted";
	sleep 1;
done

set -a
. /tmp/.secrets/.env
set +a

cat /tmp/.secrets/.env

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
	openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=FR/ST=Paris/L=42/O=${WP_USER}/CN=${WP_URL}";
	echo "Nginx: Certificate and key are set up!";
else 
	echo "Nginx: Certificate and key already exist";
fi

echo "Nginx set up ! Starting Nginx";

exec "$@"