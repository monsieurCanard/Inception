FROM debian:bullseye

RUN apt-get update

RUN mkdir -p /var/www/html/static_site

COPY ./www/ /var/www/html/static_site

CMD ["echo", "Static site is created!"]