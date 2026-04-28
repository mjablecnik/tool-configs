---
inclusion: always
---

# Backend Service Standards

## Required Files

Every backend service MUST contain the following files:

- `.env` — actual environment values (gitignored, never committed)
- `.env.example` — template with all keys and placeholder values (committed)
- `Dockerfile` — multi-stage build for production
- `docker-compose.yml` — local development with `env_file: .env`
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

1. Parses `APP_NAME` from `fly.toml`
2. Creates the Fly.io app if it doesn't exist (`fly launch --no-deploy`)
3. Reads `.env` file
4. Skips empty lines, comments, and empty values
5. Skips keys already defined in `fly.toml [env]` (non-secret config)
6. Sets remaining key-value pairs as Fly.io secrets via `fly secrets set --app <APP_NAME>`

## docker-compose.yml

- Uses `env_file: .env` for local configuration
- Exposes the same ports as defined in `fly.toml`
- Uses `restart: unless-stopped`

## README.md Requirements

Every backend service README MUST include these sections:

### Local Docker Setup
- How to configure `.env` (copy from `.env.example`)
- How to build and run with `docker compose up --build`
- How to stop with `docker compose down`

### Fly.io Deployment
- How to setup and set secrets (`./fly-setup.sh`)
- How to deploy (`fly deploy`)
- Useful commands (logs, status, ssh)

## Default Deployment Target

The default deployment target is Fly.io unless explicitly stated otherwise for a specific service.

## Exceptions

None. All backend services follow these standards.
