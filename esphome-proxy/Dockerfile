ARG BUILD_ARCH
# hadolint ignore=DL3006
FROM ghcr.io/hassio-addons/debian-base/${BUILD_ARCH}:9.3.0

RUN apt-get -qq update \
  && apt-get -qq install --no-install-recommends -y nginx \
  && (apt-get autoremove -y; apt-get autoclean -y)

# Copy root filesystem
ADD nginx.conf.gtpl /
ADD entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/bin/sh", "-c", "/entrypoint.sh"]
# Build arguments
ARG BUILD_ARCH
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION}

ENTRYPOINT ["/entrypoint.sh"]
