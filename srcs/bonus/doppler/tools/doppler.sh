#!/bin/bash

export DOPPLER_TOKEN=$(cat $DOPPLER_TOKEN);

mkdir -p /tmp/.secrets;

echo "Waiting for doppler secrets to be mounted";

doppler secrets download --no-file --format env > /tmp/.secrets/.env;

if [ ! -f /tmp/.secrets/.env ]; then
	echo "Doppler secrets error";
	exit 1;
fi

echo "Doppler secrets downloaded";

unset DOPPLER_TOKEN;

exec echo "Doppler secrets are ready";