#!/bin/bash

mkdir -p /admin

cp /tmp/adminer.php /admin/index.php
cp /tmp/adminer.css /admin/adminer.css

exec "$@"