# Toepassen op de repository

Pak deze ZIP uit in de hoofdmap van `hassio-addons`.

Verwijder daarna de verouderde Nginx-bestanden en -mappen die niet meer nodig zijn:

```bash
rm -rf esphome-proxy/rootfs/etc/nginx/includes
rm -rf esphome-proxy/rootfs/etc/nginx/servers
rm -rf esphome-proxy/rootfs/etc/nginx/templates
rm -f  esphome-proxy/rootfs/etc/nginx/nginx.conf
```

De volgende bestanden blijven of worden geplaatst:

```text
esphome-proxy/config.yaml
esphome-proxy/Dockerfile
esphome-proxy/run.sh
esphome-proxy/rootfs/etc/nginx/nginx.conf.template
esphome-proxy/translations/en.yaml
esphome-proxy/translations/nl.yaml
esphome-proxy/README.md
esphome-proxy/DOCS.md
esphome-proxy/CHANGELOG.md
```

Controleer daarna:

```bash
git status
git diff --check
```

Commit en push:

```bash
git add esphome-proxy
git commit -m "Harden ESPHome Proxy 2.0.1"
git push
```

De bestaande pull request start vervolgens automatisch een nieuwe build.
