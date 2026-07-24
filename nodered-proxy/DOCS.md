# Node-RED Proxy configuratie

## Optie `server`

Het adres van de externe Node-RED-installatie in `host:poort`-formaat:

```yaml
server: node-red.local:1880
```

Een IPv4-adres is ook toegestaan:

```yaml
server: 192.168.1.50:1880
```

Gebruik geen `http://`, pad of afsluitende slash. Deze versie ondersteunt een HTTP-backend met een hostnaam of IPv4-adres.

## Werking en beveiliging

De app publiceert geen netwerkpoort op de Home Assistant-host. De proxy luistert alleen op de interne Ingress-poort. Home Assistant verzorgt de gebruikersauthenticatie.

De Supervisor bewaakt de interne TCP-poort met de ingebouwde watchdog.

## Node-RED-instellingen

Deze proxy werkt het eenvoudigst wanneer Node-RED op de hoofdroute `/` draait. Aangepaste waarden voor `httpAdminRoot` of complexe reverse-proxy-instellingen kunnen extra configuratie in Node-RED vereisen.

## Problemen oplossen

### `502 Bad Gateway`

Controleer:

1. of Node-RED draait;
2. of de ingestelde poort klopt;
3. of de hostnaam vanuit Home Assistant kan worden opgelost;
4. of een firewall verkeer vanaf Home Assistant blokkeert;
5. of Node-RED op een LAN-bereikbaar adres luistert.

Test tijdelijk met het IP-adres om DNS uit te sluiten.

### De editor opent, maar deployen of live updates werken niet

Node-RED gebruikt WebSockets. Controleer of een eventuele extra reverse proxy tussen Home Assistant en deze app WebSocket-upgrades toestaat.

### De configuratie wordt afgekeurd

Gebruik uitsluitend:

```text
hostnaam-of-ip:poort
```
