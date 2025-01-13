FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	redis-server \
	&& rm -rf /var/lib/apt/lists/*

COPY ./conf/redis.conf /etc/redis/redis.conf

RUN mkdir -p /var/run/redis && \
	chown -R redis:redis /var/run/redis

EXPOSE 6379

CMD [ "redis-server", "/etc/redis/redis.conf" ]