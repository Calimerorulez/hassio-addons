# Changelog

## 2.0.0

- Migrated from `config.json` to `config.yaml`.
- Migrated to the official Home Assistant base image.
- Replaced the legacy init and service layout with a single Bashio startup script.
- Added strict backend address validation.
- Added explicit Nginx configuration validation before startup.
- Added WebSocket support for the Node-RED editor and runtime.
- Added a Supervisor TCP watchdog.
- Added Dutch and English configuration translations.
- Added current app metadata and OCI labels.
- Restricted supported architectures to `amd64` and `aarch64`.
- Preserved the existing `server: host:port` configuration format.

## 1.0.8

- Legacy release.
