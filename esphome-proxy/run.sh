#!/usr/bin/with-contenv bashio

set -euo pipefail

readonly SERVER="$(bashio::config 'server')"
readonly TEMPLATE="/etc/nginx/nginx.conf.template"
readonly CONFIG="/etc/nginx/nginx.conf"

# Validate again at runtime because this value is inserted into Nginx config.
if [[ ! "${SERVER}" =~ ^([A-Za-z0-9]([A-Za-z0-9.-]*[A-Za-z0-9])?|([0-9]{1,3}\.){3}[0-9]{1,3}):([1-9][0-9]{0,4})$ ]]; then
    bashio::log.fatal "Invalid server value: ${SERVER}"
    bashio::log.fatal "Use hostname:port or IPv4-address:port, without http:// or a path."
    exit 1
fi

readonly HOST="${SERVER%:*}"
readonly PORT="${SERVER##*:}"

if (( PORT < 1 || PORT > 65535 )); then
    bashio::log.fatal "Port must be between 1 and 65535."
    exit 1
fi

# Reject invalid IPv4 octets when the host has an IPv4-shaped value.
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
    bashio::log.warning "Nginx will still start and retry resolution after an app restart."
fi

bashio::log.info "Configuring proxy target: ${SERVER}"

sed \
    -e "s|%%ESPHOME_SERVER%%|${SERVER}|g" \
    "${TEMPLATE}" > "${CONFIG}"

if ! nginx -t; then
    bashio::log.fatal "The generated Nginx configuration is invalid."
    exit 1
fi

bashio::log.info "Starting ESPHome Proxy on the internal Ingress port 8099."
exec nginx -g "daemon off;"
