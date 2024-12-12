FROM debian:bullseye

#Install necessary package from php

RUN apt-get upgrade && apt-get update && apt-get -y install \
	wget \
	php \
	php-cgi \
	php-mysql \
	php-fpm \
	php-pdo \
	php-gd php-cli \
	php-mbstring \
	&& rm -rf /var/lib/apt/lists/*


RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -O /tmp/wp-cli.phar
RUN chmod +x /tmp/wp-cli.phar
#Copy the necessary tools to download wordpress

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

#Create the folder to enable php start

RUN mkdir /var/run/php

#Launch script

COPY ./tools/create_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/create_wordpress.sh


ENTRYPOINT ["/usr/local/bin/create_wordpress.sh"]

WORKDIR /var/www/html/

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]