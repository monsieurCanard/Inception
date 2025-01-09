FROM debian:bullseye

RUN apt-get upgrade && apt-get update && apt-get -y install \
	wget \
	php \
	php-cgi \
	php-mysql \
	php-fpm \
	php-pdo \
	php-redis \
	php-gd php-cli \
	php-mbstring \
	&& rm -rf /var/lib/apt/lists/*


COPY ./www /tmp/www
RUN chmod -R 755 /tmp/www

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	-O /tmp/wp-cli.phar && chmod +x /tmp/wp-cli.phar

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
RUN mkdir /var/run/php

COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh

WORKDIR /var/www/html/

ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]