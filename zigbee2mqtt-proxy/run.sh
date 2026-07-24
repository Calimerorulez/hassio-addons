#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

set -euo pipefail

SERVER="$(bashio::config 'server')"
AUTH_TOKEN="$(bashio::config 'auth_token')"
readonly SERVER AUTH_TOKEN

readonly TEMPLATE="/etc/nginx/nginx.conf.template"
readonly CONFIG="/etc/nginx/nginx.conf"

if [[ ! "${SERVER}" =~ ^https?://[^/[:space:]]+:[0-9]{1,5}$ ]]; then
    bashio::log.fatal "Invalid server value: ${SERVER}"
    bashio::log.fatal "Use http://host:port or https://host:port without a path or trailing slash."
    exit 1
fi

# Escape values used in sed replacements.
SERVER_ESCAPED="${SERVER//&/\\&}"
AUTH_TOKEN_ESCAPED="${AUTH_TOKEN//&/\\&}"
readonly SERVER_ESCAPED AUTH_TOKEN_ESCAPED

sed \
    -e "s|%%SERVER%%|${SERVER_ESCAPED}|g" \
    -e "s|%%AUTH_TOKEN%%|${AUTH_TOKEN_ESCAPED}|g" \
    "${TEMPLATE}" > "${CONFIG}"

if ! nginx -t -c "${CONFIG}"; then
    bashio::log.fatal "The generated Nginx configuration is invalid."
    exit 1
fi

bashio::log.info "Starting Zigbee2MQTT Proxy for ${SERVER}"
exec nginx -c "${CONFIG}"
