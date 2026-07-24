# ESPHome Proxy configuration

## `server`

Address of the external ESPHome Device Builder in `host:port` format.

Examples:

```yaml
server: esphome.local:6052
```

```yaml
server: 192.168.1.50:6052
```

The current release supports hostnames and IPv4 addresses over HTTP.

## Troubleshooting

### `502 Bad Gateway`

The Home Assistant app container cannot connect to the configured backend.

Check:

1. The ESPHome Device Builder is running.
2. The port is correct.
3. DNS inside Home Assistant can resolve the hostname.
4. A firewall is not blocking traffic from Home Assistant.
5. The Device Builder listens on an address reachable over the LAN.

Using the backend IP address temporarily is a useful DNS test.

### Page opens but live logs fail

Confirm that no reverse proxy between this app and the Device Builder removes
WebSocket headers. ESPHome Proxy forwards WebSocket upgrade headers and disables
proxy buffering.

### Configuration is rejected

Use only:

```text
hostname-or-ip:port
```

Do not include `http://`, a path or a trailing slash.
