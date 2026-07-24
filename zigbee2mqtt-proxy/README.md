# Zigbee2MQTT Proxy

Deze Home Assistant-app maakt de frontend van een extern draaiende
Zigbee2MQTT-installatie beschikbaar via Home Assistant Ingress.

> Deze app bevat Zigbee2MQTT zelf niet.

## Configuratie

```yaml
server: http://192.168.2.43:8080
auth_token: ""
```

Gebruik de volledige lokale URL inclusief poort en zonder afsluitende slash.
