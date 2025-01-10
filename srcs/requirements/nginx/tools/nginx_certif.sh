#!/bin/bash

if [ ! -f /etc/ssl/certs/nginx.crt ]; then
openssl req -x509 -nodes -days 365 -newkey rsa:4096 -keyout /etc/ssl/private/nginx.key -out /etc/ssl/certs/nginx.crt -subj "/C=FR/ST=Paris/L=42/O=antgabri/CN=antgabri.42.fr";
echo "Nginx: Certificate and key are set up!";
fi

# mkdir -p /var/www/html/admin
# cd /var/www/html/admin
# wget http://www.adminer.org/latest.php -O adminer.php

exec "$@"