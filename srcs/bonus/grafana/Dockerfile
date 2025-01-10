FROM debian:bullseye

RUN apt-get update && apt-get install -y \
	apt-transport-https \
	software-properties-common \
	wget \
	gnupg2

RUN mkdir -p /etc/apt/keyrings/
RUN wget -q -O - https://apt.grafana.com/gpg.key | gpg --dearmor | tee /etc/apt/keyrings/grafana.gpg > /dev/null
RUN echo "deb [signed-by=/etc/apt/keyrings/grafana.gpg] https://apt.grafana.com stable main" | tee -a /etc/apt/sources.list.d/grafana.list


RUN apt-get -y update && apt-get -y install grafana

COPY ./conf/grafana.ini /usr/share/grafana/conf/custom.ini

# RUN mkdir -p /var/lib/grafana/dashboards

EXPOSE 3000

CMD ["/usr/sbin/grafana-server", "--homepath=/usr/share/grafana"]