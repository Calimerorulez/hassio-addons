# ESPHome Proxy configuratie

## Optie `server`

Het adres van de externe ESPHome Device Builder in `host:poort`-formaat.

```yaml
server: esphome.local:6052
```

Een IPv4-adres is ook toegestaan:

```yaml
server: 192.168.1.50:6052
```

Gebruik geen `http://`, pad of afsluitende slash. Deze versie ondersteunt een
HTTP-backend met een hostnaam of IPv4-adres.

## Werking en beveiliging

De app publiceert geen netwerkpoort op de Home Assistant-host. De proxy luistert
alleen op de interne Ingress-poort en accepteert HTTP-verkeer van de Supervisor
Ingress-gateway. Home Assistant verzorgt daardoor de gebruikersauthenticatie.

De Supervisor bewaakt de interne TCP-poort met de ingebouwde watchdog.

## Problemen oplossen

### `502 Bad Gateway`

De app kan de geconfigureerde ESPHome-backend niet bereiken. Controleer:

1. of ESPHome Device Builder draait;
2. of de poort klopt;
3. of de hostnaam binnen Home Assistant kan worden opgelost;
4. of een firewall verbindingen vanaf Home Assistant blokkeert;
5. of Device Builder op een LAN-bereikbaar adres luistert.

Test tijdelijk met het IP-adres van de backend om een DNS-probleem uit te sluiten.

### De pagina opent, maar live logs werken niet

Controleer of een eventuele extra reverse proxy tussen deze app en ESPHome
WebSocket-verkeer ondersteunt. ESPHome Proxy stuurt WebSocket-upgrades door en
schakelt buffering uit.

### De configuratie wordt afgekeurd

Gebruik uitsluitend:

```text
hostnaam-of-ip:poort
```
