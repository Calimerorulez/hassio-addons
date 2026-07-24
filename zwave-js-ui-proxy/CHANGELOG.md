# Changelog

## 2.0.0

- Migrated from `config.json` to `config.yaml`.
- Migrated to the official Home Assistant base image.
- Replaced Tempio and the legacy entrypoint with Bashio.
- Added strict backend URL validation.
- Added Nginx configuration validation before startup.
- Added WebSocket support.
- Added a Supervisor TCP watchdog.
- Added Dutch and English configuration translations.
- Removed the obsolete exposed port and `config` mapping.
- Added current OCI metadata.
- Kept support for `amd64` and `aarch64`.

## 0.1.8

- Legacy release.
