#!/usr/bin/with-contenv sh

echo "Generating nginx config..."

tempio /nginx.conf.gtpl > /tmp/nginx.conf || {
  echo "Failed to generate nginx config"
  exit 1
}

echo "Testing nginx config..."
nginx -t -c /tmp/nginx.conf || exit 1

echo "Starting nginx..."
exec nginx -c /tmp/nginx.conf
