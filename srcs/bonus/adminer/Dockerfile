FROM debian:bullseye

RUN apt-get update && apt-get install -y wget

RUN wget http://www.adminer.org/latest.php -O /tmp/adminer.php

COPY ./conf/adminer.css /tmp/adminer.css
COPY ./tools/adminer.sh /usr/local/bin/adminer.sh

RUN chmod +x /usr/local/bin/adminer.sh

EXPOSE 8080

ENTRYPOINT ["/usr/local/bin/adminer.sh"]