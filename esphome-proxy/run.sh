#!/usr/bin/with-contenv bashio
# shellcheck shell=bash
set -euo pipefail

SERVER="$(bashio::config 'server')"
readonly SERVER
readonly TEMPLATE="/etc/nginx/nginx.conf.template"
readonly CONFIG="/etc/nginx/nginx.conf"

if [[ ! "${SERVER}" =~ ^([A-Za-z0-9]([A-Za-z0-9.-]*[A-Za-z0-9])?|([0-9]{1,3}\.){3}[0-9]{1,3}):([1-9][0-9]{0,4})$ ]]; then
    bashio::log.fatal "Invalid server value: ${SERVER}"
    exit 1
fi

sed -e "s|%%SERVER%%|${SERVER}|g" "${TEMPLATE}" > "${CONFIG}"
nginx -t -c "${CONFIG}"
bashio::log.info "Starting ESPHome Proxy for ${SERVER}"
exec nginx -c "${CONFIG}"
