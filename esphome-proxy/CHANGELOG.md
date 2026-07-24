# Changelog

## 2.0.1

- Added a Supervisor TCP watchdog.
- Added Dutch and English configuration translations.
- Simplified the Nginx filesystem layout.
- Improved proxy access logging and startup messages.
- Added a non-fatal DNS resolution warning at startup.
- Added current app metadata and OCI labels.
- Clarified Ingress authentication and troubleshooting documentation.
- Kept the existing `server: host:port` configuration fully compatible.

## 2.0.0

- Migrated from `config.json` to `config.yaml`.
- Migrated to the official Home Assistant base image.
- Removed the legacy `cont-init.d` and `services.d` layout.
- Added strict backend address validation.
- Added explicit Nginx configuration validation before startup.
- Preserved the existing `server: host:port` configuration format.
- Restricted supported architectures to `amd64` and `aarch64`.
