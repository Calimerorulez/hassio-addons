# Z-Wave JS UI Proxy

Deze Home Assistant-app toont een extern draaiende Z-Wave JS UI-installatie via Home Assistant Ingress.

> Deze app bevat Z-Wave JS UI zelf niet.

## Configuratie

```yaml
server: http://zwave-js-ui.local:8091
```

Een IP-adres kan ook:

```yaml
server: http://192.168.2.43:8091
```

Gebruik geen pad of afsluitende slash.
