# Comet Server in Docker

[![@CometBackup on Twitter](https://img.shields.io/badge/twitter-%40CometBackup-blue.svg?style=flat)](https://twitter.com/CometBackup)
[![Comet EULA](https://img.shields.io/badge/license-Comet%20EULA-yellowgreen.svg)](https://cometbackup.com/conditions)

Run and manage your self-hosted Comet Server using [Docker](https://www.docker.com/) or any OCI-compatible container runtime.

View the demo video here: <https://youtu.be/iMFnx0QgYag>

> **Important:** A Comet Server serial number is required. If you do not yet have one, please sign into your account and generate one on the [My Servers](https://account.cometbackup.com/my_servers) page.

## Tags

The following tags are available:

|Tag|Description
|---|---
|`latest`|The latest Voyager release version
|MAJOR.MINOR|The latest release in the selected series (e.g. `23.3`)
|MAJOR.MINOR.PATCH|A specific released version of Comet Server (e.g. `23.3.7`)

## Usage

With `docker run`:

```bash
docker run -ti \
  -p 8060:8060 \
  -e COMET_LICENSE_SERIAL= \
  -v "/var/lib/cometd/:/var/lib/cometd" \
  -v "/var/log/cometd/:/var/log/cometd" \
  ghcr.io/cometbackup/comet-server:latest
```

With docker compose (`docker-compose.yml`):

Use the minimal yaml below, or take a look at [the examples](examples/docker-compose-full) for more configuration options.

```yaml
version: "3"
services:
  cometd:
    image: ghcr.io/cometbackup/comet-server:latest
    ports:
      # Let's Encrypt / HTTPS
      # Port 443 required AutoSSL functionality
      # - "443:443"
      - "8060:8060"
    environment:
      # Server Configuration
      # These will be applied on first boot
      - "COMET_LICENSE_SERIAL="
      # Alternatively, you can provide your Comet account email, and a token
      # with the 'License::CreateLicense' permission -
      # This will generate a new Self-Hosted server license automatically
      # - "COMET_ACCOUNT_EMAIL="
      # - "COMET_ACCOUNT_TOKEN="
    volumes:
      - "/var/lib/cometd/:/var/lib/cometd"
      - "/var/log/cometd/:/var/log/cometd"
```

### Migrating from other Comet Server distributions

The Comet Server docker container runs as an isolated user within the container (`cometd:cometd`) with UID:GID `100:101`. The stored files inside `/var/lib/cometd` and `/var/log/cometd` use an identical layout to the other available Linux packages; when migrating, you should `chmod` the files to the target UID:GID so that the container process is able to read and write to them.

## Environment Variables

The following environment variables are available:

|Name|Desc|Required
|---|---|---
|`COMET_LICENSE_SERIAL`|A pre-generated Self-Hosted serial number|No
|`COMET_ACCOUNT_EMAIL`|Your Comet Backup account email, used for dynamic license serial generation on first start-up|Required if `COMET_LICENSE_SERIAL` not provided
|`COMET_ACCOUNT_TOKEN`|Your Comet Backup account API token with the `License::CreateLicense` permission, used for dynamic license serial generation on first start-up|Required if `COMET_LICENSE_SERIAL` not provided

## Hooks

The container manages the Comet Server service internally using a Bash script. You can hook into this script to perform actions on lifecycle events.

The following hooks are available:

|Hook|Runs
|---|---
|`cometd::hook::config_validated`|On initial server start-up, after the config has been validated and serial has been created (on first start if email/token was provided)
|`cometd::hook::on_start`|On initial server start-up, after `config_validated`
|`cometd::hook::on_failure`|On an unexpected server shutdown, but before service restart

Example usage of hooks can be found in `examples/docker-compose-full/entrypoint.d`