#!/usr/bin/with-contenv bashio
# shellcheck shell=bash

set -euo pipefail

SERVER="$(bashio::config 'server')"
readonly SERVER
readonly TEMPLATE="/etc/nginx/nginx.conf.template"
readonly CONFIG="/etc/nginx/nginx.conf"

# Only plain HTTP(S), a hostname or IPv4 address, and an explicit port are
# accepted. Paths, query strings, credentials and trailing slashes are rejected.
if [[ ! "${SERVER}" =~ ^https?://([A-Za-z0-9]([A-Za-z0-9.-]*[A-Za-z0-9])?|([0-9]{1,3}\.){3}[0-9]{1,3}):([1-9][0-9]{0,4})$ ]]; then
    bashio::log.fatal "Invalid server value: ${SERVER}"
    bashio::log.fatal "Use http://hostname:port or https://hostname:port, without a path or trailing slash."
    exit 1
fi

SERVER_WITHOUT_SCHEME="${SERVER#*://}"
readonly SERVER_WITHOUT_SCHEME
HOST="${SERVER_WITHOUT_SCHEME%:*}"
readonly HOST
PORT="${SERVER_WITHOUT_SCHEME##*:}"
readonly PORT

if (( PORT < 1 || PORT > 65535 )); then
    bashio::log.fatal "Port must be between 1 and 65535."
    exit 1
fi

if [[ "${HOST}" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    IFS='.' read -r o1 o2 o3 o4 <<< "${HOST}"
    for octet in "${o1}" "${o2}" "${o3}" "${o4}"; do
        if (( 10#${octet} > 255 )); then
            bashio::log.fatal "Invalid IPv4 address: ${HOST}"
            exit 1
        fi
    done
fi

if ! getent hosts "${HOST}" >/dev/null 2>&1; then
    bashio::log.warning "Backend hostname '${HOST}' cannot currently be resolved."
fi

bashio::log.info "Configuring proxy target: ${SERVER}"

sed -e "s|%%ZWAVE_SERVER%%|${SERVER}|g" "${TEMPLATE}" > "${CONFIG}"

if ! nginx -t; then
    bashio::log.fatal "The generated Nginx configuration is invalid."
    exit 1
fi

bashio::log.info "Starting Z-Wave JS UI Proxy on internal Ingress port 8099."
exec nginx -g "daemon off;"
