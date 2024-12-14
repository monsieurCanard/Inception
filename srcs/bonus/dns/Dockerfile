FROM debian:bulleye

RUN apt update -y && apt-get dnsmasq

COPY dnsmasq.conf /etc/dnsmasq.conf

CMD ["dnsmasq", "-k"]

EXPOSE 53/udp