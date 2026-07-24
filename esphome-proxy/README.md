# ESPHome Proxy

ESPHome Proxy exposes an ESPHome Device Builder running outside Home Assistant
through Home Assistant Ingress.

This app does **not** run ESPHome itself. It only proxies the Device Builder web
interface from another host, container, VM or LXC.

## Why use it?

- Keep ESPHome independent from Home Assistant.
- Continue using ESPHome from the Home Assistant sidebar.
- Let Home Assistant handle access to the embedded interface.
- Preserve WebSocket and streaming connections used for logs and builds.

## Installation

1. Add this repository to the Home Assistant App Store:
   `https://github.com/Calimerorulez/hassio-addons`
2. Install **ESPHome Proxy**.
3. Configure the external Device Builder address.
4. Start the app.
5. Enable **Show in sidebar**.

Example configuration:

```yaml
server: esphome.local:6052
```

An IP address is also supported:

```yaml
server: 192.168.1.50:6052
```

## Requirements

- The ESPHome Device Builder must be reachable from the Home Assistant app
  container.
- The backend must currently use plain HTTP.
- The backend address must be a hostname or IPv4 address with a TCP port.

## Security

The proxy listens only on the internal Ingress port and allows requests only
from the Home Assistant Supervisor Ingress gateway (`172.30.32.2`).

Do not expose the internal proxy port manually.

## Upgrade from 1.x

Version 2.0 keeps the existing `server: host:port` option. Existing users should
not need to re-enter their configuration.

The app now uses the current `config.yaml` format, the official Home Assistant
base image and a simplified startup script.

## Support

Open an issue in the repository and include:

- Home Assistant version
- ESPHome Device Builder version
- App logs
- Backend address format, with private details redacted
