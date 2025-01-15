FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl wget

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default
COPY ./tools/nginx_certif.sh /var/www

RUN chmod +x /var/www/nginx_certif.sh

RUN chmod -R 755 /var/www/html && \
	chown -R www-data:www-data /var/www/html

ENTRYPOINT [ "var/www/nginx_certif.sh" ]

CMD ["nginx", "-g", "daemon off;"]