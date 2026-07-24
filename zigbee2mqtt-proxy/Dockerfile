FROM ghcr.io/home-assistant/base:latest

ARG BUILD_VERSION
ARG BUILD_ARCH

RUN apk add --no-cache nginx

COPY rootfs /
COPY run.sh /run.sh

RUN chmod 0755 /run.sh

LABEL \
    io.hass.version="${BUILD_VERSION}" \
    io.hass.type="app" \
    io.hass.arch="${BUILD_ARCH}" \
    org.opencontainers.image.title="Zigbee2MQTT Proxy" \
    org.opencontainers.image.description="Home Assistant Ingress proxy for an external Zigbee2MQTT frontend" \
    org.opencontainers.image.source="https://github.com/Calimerorulez/hassio-addons" \
    org.opencontainers.image.licenses="MIT"

CMD ["/run.sh"]
