# Comet Server Docker Compose Example

Run a Comet Server using Docker Compose. Applying configuration patches on startup, and watch for unexpected restarts.

**Requirements:**

- `docker`
- `docker-compose`
- A Comet Account with a linked API token. [Manage API Tokens](https://account.cometbackup.com/manage_api_tokens)

**Usage:**

To get started, clone this repo (or download as a zip) onto your local machine, and run the following commands once you have navigated to `examples/docker-compose-full` -

> _Note_: Please make sure to swap the environment variable values with your own. 

> _Note_: The `COMET_ACCOUNT_TOKEN` must have the `License::CreateLicense` permission.

```bash
export COMET_ACCOUNT_EMAIL="<your account.cometbackup.com email>"
export COMET_ACCOUNT_TOKEN="<your api key>"

docker compose up
```

The following will happen:

1. Docker will pull the latest Comet Server container and start it
2. First start up will be detected -
   - A Self-Hosted license will be created with the API token provided
   - A blank server config will be generated at `/var/lib/cometd/cometd.cfg`
3. The configuration patches will be applied from `00-config-validated.sh`
4. The Comet Server will start up

You can now access the Comet Server at <http://localhost:8060>

**Clean Up:**

```bash
docker compose down
docker compose rm -v
```