# Installatie van alle drie de proxies

Pak deze ZIP uit in de hoofdmap van je `hassio-addons` repository.

```bash
cd ~/hassio-addons
git checkout main
git pull
git checkout -b modernize-all-proxies

unzip ~/Downloads/hassio-proxies-bundle.zip
```

Verwijder daarna alleen de verouderde bestanden die nog in je repository staan:

```bash
rm -f esphome-proxy/config.json
rm -f nodered-proxy/config.json
rm -f zwave-js-ui-proxy/config.json
rm -f zwave-js-ui-proxy/entrypoint.sh
rm -f zwave-js-ui-proxy/nginx.conf.gtpl

chmod +x esphome-proxy/run.sh
chmod +x nodered-proxy/run.sh
chmod +x zwave-js-ui-proxy/run.sh
```

De ZIP bevat geen `icon.png` of `logo.png`; je bestaande artwork blijft dus behouden.

Pas `.github/workflows/builder.yaml` aan met de jobs uit `builder-jobs.yaml`.

Controleer vervolgens:

```bash
git diff --check
git status
git diff -- esphome-proxy nodered-proxy zwave-js-ui-proxy .github/workflows/builder.yaml
```

Commit en push:

```bash
git add esphome-proxy nodered-proxy zwave-js-ui-proxy .github/workflows/builder.yaml
git commit -m "Modernize all proxy apps"
git push -u origin modernize-all-proxies
```
