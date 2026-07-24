# Changelog

## 2.0.0

- Migrated from `config.json` to `config.yaml`.
- Migrated to the official Home Assistant base image.
- Removed the legacy `cont-init.d` and `services.d` layout.
- Added strict backend address validation.
- Added explicit Nginx configuration validation before startup.
- Improved startup and error logging.
- Preserved the existing `server: host:port` configuration format.
- Restricted supported architectures to `amd64` and `aarch64`.
- Updated Ingress handling, WebSocket forwarding and streaming behaviour.
- Added current documentation and automated build validation.

## 1.1.1

- Corrected port.

## 1.1.0

- Moved to Debian image.

## 1.0.6

- Updated Debian base image to 7.7.1.

## 1.0.5

- Updated base image to Debian base 7.3.3.

## 1.0.4

- Updated base image to Debian base 7.3.1.

## 1.0.3

- Updated base image to Debian base 7.2.0.

## 1.0.0

- Initial release.
