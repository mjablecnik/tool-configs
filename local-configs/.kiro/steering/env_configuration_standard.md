# Environment Configuration Standard

## .env File Pattern

All projects must use `.env` files for configuration, regardless of programming language or framework.

## Rules

1. `.env` — contains actual secrets and configuration values. MUST be listed in `.gitignore` and NEVER committed to version control.
2. `.env.example` — contains all environment variable keys with placeholder or default values. MUST be committed to version control as a template for other developers.

## .env.example Format

- List every environment variable the project uses
- Use descriptive placeholder values for required secrets (e.g., `your-api-key-here`)
- Use actual default values for optional configuration (e.g., `PORT=3000`)
- Add comments to group and explain variables

Example:
```env
# API Keys
OPENROUTER_API_KEY=your-api-key-here

# Server Configuration
APP_PORT=3000
```

## .gitignore

Always ensure `.env` is in `.gitignore`:
```
.env
.env.local
.env.*.local
```

`.env.example` must NOT be in `.gitignore`.

## Loading

- Node.js/TypeScript: Use `dotenv` package
- Python: Use `python-dotenv` package
- Go: Use `godotenv` package
- Rust: Use `dotenvy` crate
- Other languages: Use the idiomatic .env loading library for that ecosystem

## Docker

When using Docker, reference the `.env` file via `env_file` in `docker-compose.yml` rather than hardcoding values in the Dockerfile.

## Consistency Rule

Whenever a variable is added to or removed from `.env`, the same change MUST be applied to `.env.example` immediately. The two files must always have the same set of variable keys. In `.env.example`, use placeholder values for secrets and actual defaults for non-secret config.

## Key Principles

- Never hardcode secrets or API keys in source code
- Never commit `.env` to version control
- Always provide `.env.example` so new developers know which variables to set
- Always keep `.env` and `.env.example` in sync — same keys, same structure
- Use sensible defaults for non-secret configuration values
- Document required vs optional variables in `.env.example` with comments
