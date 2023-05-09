# Comet Server in Docker

> **Important:** A Comet Server serial number is required. If you do not yet have one, please sign into your account and generate one on the [My Servers](https://account.cometbackup.com/my_servers) page.

**Usage**

Run and manage your Comet Server using Docker by running the following command, or by using the `docker-compose.yml` configuration below.

```bash
docker run \
  -p 8060:8060 \
  -e COMET_LICENSE_SERIAL= \
  -v "/var/lib/cometd/:/var/lib/cometd" \
  -v "/var/log/cometd/:/var/log/cometd" \
  ghcr.io/cometbackup/comet-server:23.3.7
```

```yaml
version: "3"
services:
  cometd:
    image: ghcr.io/cometbackup/comet-server:23.3.7
    ports:
      # Let's Encrypt / HTTPS
      # Port 443 required AutoSSL functionality
      # - "443:443"
      - "8060:8060"
    environment:
      # Server Configuration
      # These will be applied on first boot
      - "COMET_LICENSE_SERIAL="
    volumes:
      - "/var/lib/cometd/:/var/lib/cometd"
      - "/var/log/cometd/:/var/log/cometd"
```
