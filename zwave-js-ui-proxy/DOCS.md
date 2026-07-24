# Z-Wave JS UI Proxy configuratie

## Optie `server`

Gebruik de volledige URL inclusief poort:

```yaml
server: http://zwave-js-ui.local:8091
```

Toegestaan zijn `http://` en `https://`, gevolgd door een hostnaam of IPv4-adres en een expliciete poort. Een pad, querystring, gebruikersnaam, wachtwoord of afsluitende slash wordt niet geaccepteerd.

## Problemen oplossen

### 502 Bad Gateway

Controleer of:

1. Z-Wave JS UI draait;
2. de hostnaam of het IP-adres klopt;
3. poort 8091 of je aangepaste poort bereikbaar is vanaf Home Assistant;
4. een firewall het verkeer niet blokkeert;
5. Z-Wave JS UI op een LAN-bereikbaar adres luistert.

### De interface opent, maar live updates werken niet

De proxy ondersteunt WebSockets. Controleer eventuele extra reverse proxies tussen Home Assistant en deze app.
