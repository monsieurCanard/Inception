FROM debian:bullseye

RUN apt-get update && apt-get install -y vsftpd

COPY ./conf/vsftpd.conf /etc/vsftpd.conf
COPY ./tools/ftp_setup.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/ftp_setup.sh
RUN mkdir -p /var/run/vsftpd/empty

EXPOSE 21

ENTRYPOINT ["/usr/local/bin/ftp_setup.sh"]

CMD ["vsftpd", "/etc/vsftpd.conf"]