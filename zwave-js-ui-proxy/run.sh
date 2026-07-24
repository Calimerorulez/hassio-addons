#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -euo pipefail

SERVER="$(bashio::config 'server')"
readonly SERVER
readonly TEMPLATE="/etc/nginx/nginx.conf.template"
readonly CONFIG="/etc/nginx/nginx.conf"

if [[ ! "${SERVER}" =~ ^https?://[^/[:space:]]+:[0-9]{1,5}$ ]]; then
    bashio::log.fatal "Invalid server value: ${SERVER}"
    exit 1
fi

sed -e "s|%%SERVER%%|${SERVER}|g" "${TEMPLATE}" > "${CONFIG}"
nginx -t -c "${CONFIG}"
bashio::log.info "Starting Z-Wave JS UI Proxy for ${SERVER}"
exec nginx -c "${CONFIG}"
