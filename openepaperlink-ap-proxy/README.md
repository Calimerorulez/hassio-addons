![amd64][amd64-shield] ![aarch64][aarch64-shield]

# OpenEpaperLink AccessPoint Proxy

This add-on exposes an OpenEpaperLink AccessPoint that runs separately from Home Assistant through Home Assistant Ingress.

> This add-on does not run OpenEpaperLink AccessPoint itself.

Configure the external AccessPoint as a host and port, for example:

```yaml
server: openepaperlink-ap.local:80
```

The add-on supports Home Assistant OS on amd64 and aarch64.

[aarch64-shield]: https://img.shields.io/badge/aarch64-yes-green.svg
[amd64-shield]: https://img.shields.io/badge/amd64-yes-green.svg
