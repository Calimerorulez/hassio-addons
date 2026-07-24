# Zigbee2MQTT Proxy

## Zigbee2MQTT voorbereiden

De frontend moet op de externe Zigbee2MQTT-installatie ingeschakeld en vanaf
Home Assistant bereikbaar zijn:

```yaml
frontend:
  enabled: true
  port: 8080
```

Je hoeft `base_url` niet aan te passen voor deze proxy.

Wanneer je Zigbee2MQTT-frontend een token gebruikt:

```yaml
frontend:
  enabled: true
  port: 8080
  auth_token: jouw-geheime-token
```

Vul hetzelfde token vervolgens in bij de app-optie `auth_token`.

## App-configuratie

```yaml
server: http://192.168.2.43:8080
auth_token: ""
```

Een hostnaam is ook mogelijk:

```yaml
server: http://zigbee2mqtt.local:8080
auth_token: ""
```

Gebruik geen pad en geen afsluitende slash.

## 502 Bad Gateway

Controleer of:

- Zigbee2MQTT draait;
- de frontend is ingeschakeld;
- het ingestelde adres en de poort kloppen;
- Home Assistant het externe adres kan bereiken;
- een firewall verkeer vanaf Home Assistant toestaat.
