# ESPHome Proxy

ESPHome Proxy toont een ESPHome Device Builder die buiten Home Assistant draait
via Home Assistant Ingress.

De app draait ESPHome niet zelf. Hij fungeert uitsluitend als reverse proxy naar
een Device Builder op een andere host, VM, container of LXC.

## Kenmerken

- Home Assistant Ingress en authenticatie
- Ondersteuning voor WebSockets en gestreamde buildlogs
- Geen gepubliceerde hostpoort
- Supervisor-watchdog
- `amd64` en `aarch64`
- Nederlandse en Engelse configuratieteksten

## Installatie

1. Voeg `https://github.com/Calimerorulez/hassio-addons` toe als repository.
2. Installeer **ESPHome Proxy**.
3. Vul het adres van Device Builder in, bijvoorbeeld:
   ```yaml
   server: esphome.local:6052
   ```
4. Start de app.
5. Schakel **Weergeven in zijbalk** in.

Zie `DOCS.md` voor probleemoplossing.
