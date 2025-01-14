FROM debian:bullseye

RUN apt-get update && apt-get install -y apt-transport-https ca-certificates curl gnupg && \
	curl -sLf --retry 3 --tlsv1.2 --proto "=https" 'https://packages.doppler.com/public/cli/gpg.DE2A7741A397C129.key' | gpg --dearmor -o /usr/share/keyrings/doppler-archive-keyring.gpg && \
	echo "deb [signed-by=/usr/share/keyrings/doppler-archive-keyring.gpg] https://packages.doppler.com/public/cli/deb/debian any-version main" | tee /etc/apt/sources.list.d/doppler-cli.list && \
	apt-get update && \
	apt-get -y install doppler

COPY ./tools/doppler.sh /usr/local/bin/doppler.sh

RUN chmod +x /usr/local/bin/doppler.sh

ENTRYPOINT [ "/usr/local/bin/doppler.sh" ]

CMD [ "sleep", "30" ]