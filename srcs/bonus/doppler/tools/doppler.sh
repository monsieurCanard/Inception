#!/bin/bash

export DOPPLER_TOKEN=$(cat $DOPPLER_TOKEN);

mkdir -p /tmp/.secrets;

doppler secrets download --no-file --format env > /tmp/.secrets/.env;

unset DOPPLER_TOKEN;

exec "$@"