FROM debian:bullseye

RUN apt-get update && apt-get install -y nginx openssl

EXPOSE 443

COPY ./conf/nginx.conf /etc/nginx/sites-enabled/default
COPY ./tools/nginx_certif.sh /var/www

RUN chmod +x /var/www/nginx_certif.sh

ENTRYPOINT [ "var/www/nginx_certif.sh" ]

CMD ["nginx", "-g", "daemon off;"]