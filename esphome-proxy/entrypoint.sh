#!/usr/bin/with-contenv sh

echo "Generating nginx config..."

tempio /nginx.conf.gtpl > /tmp/nginx.conf

nginx -t -c /tmp/nginx.conf || exit 1

exec nginx -c /tmp/nginx.conf
