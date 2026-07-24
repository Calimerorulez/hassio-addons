# Node-RED Proxy

Node-RED Proxy toont een Node-RED-installatie die buiten Home Assistant draait via Home Assistant Ingress.

De app draait Node-RED niet zelf. Hij fungeert uitsluitend als reverse proxy naar Node-RED op een andere host, VM, container of LXC.

## Kenmerken

- Home Assistant Ingress en authenticatie
- Ondersteuning voor WebSockets
- Geen gepubliceerde hostpoort
- Supervisor-watchdog
- `amd64` en `aarch64`
- Nederlandse en Engelse configuratieteksten

## Installatie

1. Voeg `https://github.com/Calimerorulez/hassio-addons` toe als repository.
2. Installeer **Node-RED Proxy**.
3. Vul het adres van Node-RED in, bijvoorbeeld:

   ```yaml
   server: node-red.local:1880
   ```

4. Start de app.
5. Schakel **Weergeven in zijbalk** in.

Zie `DOCS.md` voor probleemoplossing.
