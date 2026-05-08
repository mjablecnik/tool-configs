---
inclusion: always
---

# Backend Service Standards

## Required Files

Every backend service MUST contain the following files:

- `.env` — actual environment values (gitignored, never committed)
- `.env.example` — template with all keys and placeholder values (committed)
- `Dockerfile` — multi-stage build for production
- `start-docker.sh` — bash script that builds the Docker image and starts the container locally (uses `--env-file .env`)
- `fly.toml` — Fly.io deployment configuration (single source of truth for app name)
- `fly-setup.sh` — script that creates the Fly.io app (if needed) and sets secrets from `.env`, skipping keys already in `fly.toml [env]`
- `README.md` — must include setup and run instructions for both local Docker and Fly.io deployment

## App Name Convention

The app name is defined ONLY in `fly.toml` under `app = "..."`. All other scripts (`fly-setup.sh`, deploy scripts) MUST parse the app name from `fly.toml` instead of hardcoding it.

```sh
APP_NAME=$(grep '^app\s*=' fly.toml | sed 's/^app\s*=\s*"\(.*\)"/\1/')
```

## fly.toml Structure

- `[env]` section contains non-sensitive configuration (timeouts, ports, public URLs, feature flags)
- Sensitive values (API keys, tokens, DSNs) are NEVER in `fly.toml` — they go through `fly secrets set`

## fly-setup.sh Behavior

The script MUST be idempotent — safe to run repeatedly without errors.

1. Parses `APP_NAME` from `fly.toml`
2. Checks if the app already exists using `fly apps list`
3. Creates the app ONLY if it does not exist (`fly apps create $APP_NAME`)
4. Reads `.env` file
5. Skips empty lines, comments, and empty values
6. Skips keys already defined in `fly.toml [env]` (non-secret config)
7. Sets remaining key-value pairs as Fly.io secrets via `fly secrets set --app $APP_NAME`

### App Existence Check

Use `fly apps list` to check whether the app already exists before attempting to create it:

```sh
if fly apps list | grep -q "^$APP_NAME\s"; then
  echo "App $APP_NAME already exists, skipping creation."
else
  echo "Creating app $APP_NAME..."
  fly apps create "$APP_NAME"
fi
```

Do NOT use `fly launch` — it attempts interactive setup and fails on existing apps. Use `fly apps create` for non-interactive, idempotent app creation.

## start-docker.sh

A bash script (`#!/bin/bash`) that handles local Docker workflow:

1. Parses `APP_NAME` from `fly.toml` (used as image/container name)
2. Builds the Docker image (`docker build -t $APP_NAME .`)
3. Stops and removes any existing container with the same name
4. Runs the container with `--env-file .env`, exposing the same ports as defined in `fly.toml`

Do NOT use `docker-compose.yml`. All local Docker orchestration is handled by `start-docker.sh`.

## README.md Requirements

Every backend service README MUST include these sections:

### Local Docker Setup
- How to configure `.env` (copy from `.env.example`)
- How to build and run with `./start-docker.sh`
- How to stop with `docker stop <container-name>`

### Fly.io Deployment
- How to setup and set secrets (`./fly-setup.sh`)
- How to deploy (`fly deploy`)
- Useful commands (logs, status, ssh)

## Default Deployment Target

The default deployment target is Fly.io unless explicitly stated otherwise for a specific service.

## Exceptions

None. All backend services follow these standards.
