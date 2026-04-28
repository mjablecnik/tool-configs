---
inclusion: always
---

# Dockerfile Build Optimization

## Core Principle: Layer Caching

Docker caches each layer. When a layer changes, all subsequent layers are invalidated and rebuilt. Order your COPY/ADD instructions from least-frequently to most-frequently changed files.

## 1. Always Create a .dockerignore

Exclude everything the build doesn't need. A large build context slows down every build before it even starts.

Common excludes for any project:
- `.git/` — version history is never needed in the image
- `node_modules/`, `__pycache__/`, `.venv/`, `vendor/` — dependencies are installed inside the container
- Build outputs (`build/`, `dist/`, `target/`, `bin/`, `obj/`) — rebuilt in container
- IDE/OS files (`.vscode/`, `.idea/`, `.DS_Store`)
- Test artifacts, logs, temp files
- Runtime data mounted as volumes (media, uploads, config)
- Documentation (`docs/`, `*.md`) unless needed at runtime
- CI/CD configs (`.github/`, `.gitlab-ci.yml`)

## 2. Dependency Layer First

Always copy dependency manifests and install before copying source code. This is the single biggest optimization — dependencies change rarely, source code changes constantly.

```dockerfile
# ✅ Good — dependencies cached until manifest changes
COPY package.json bun.lock ./
RUN bun install --frozen-lockfile

COPY src ./src
RUN bun run build
```

```dockerfile
# ❌ Bad — dependencies reinstalled on every code change
COPY . .
RUN bun install && bun run build
```

Language-specific patterns:

| Language | Copy First | Install Command |
|---|---|---|
| Node.js (npm/bun/yarn/pnpm) | `package.json`, lockfile | `npm ci` / `bun install --frozen-lockfile` |
| Python (pip) | `requirements.txt` | `pip install --no-cache-dir -r requirements.txt` |
| Python (poetry) | `pyproject.toml`, `poetry.lock` | `poetry install --no-dev` |
| Python (uv) | `pyproject.toml`, `uv.lock` | `uv sync --frozen --no-dev` |
| Go | `go.mod`, `go.sum` | `go mod download` |
| Rust | `Cargo.toml`, `Cargo.lock` | `cargo fetch` |
| Dart/Flutter | `pubspec.yaml`, `pubspec.lock` | `dart pub get` / `flutter pub get` |
| Java (Maven) | `pom.xml` | `mvn dependency:go-offline` |
| Java (Gradle) | `build.gradle`, `gradle.lock` | `gradle dependencies` |
| .NET | `*.csproj`, `*.sln` | `dotnet restore` |
| Ruby | `Gemfile`, `Gemfile.lock` | `bundle install` |
| PHP | `composer.json`, `composer.lock` | `composer install --no-dev` |
| Elixir | `mix.exs`, `mix.lock` | `mix deps.get --only prod` |

## 3. Granular COPY Layers

Split source code copies by change frequency. Config files change less often than source code.

```dockerfile
# Rarely changes — cached most of the time
COPY tsconfig.json svelte.config.js vite.config.ts ./
COPY static ./static

# Changes frequently — only this layer rebuilds
COPY src ./src
```

## 4. Multi-Stage Builds

Use multi-stage builds to keep the final image small. Build tools, dev dependencies, and source code stay in the build stage.

```dockerfile
# Build stage — has all tools
FROM node:22 AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci
COPY . .
RUN npm run build

# Production stage — minimal
FROM node:22-slim
WORKDIR /app
COPY --from=build /app/build ./build
COPY --from=build /app/node_modules ./node_modules
CMD ["node", "build/index.js"]
```

For compiled languages (Go, Rust, Dart), the final image can be even smaller:

```dockerfile
# Go example — final image has only the binary
FROM golang:1.23 AS build
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o /server .

FROM gcr.io/distroless/static
COPY --from=build /server /server
CMD ["/server"]
```

## 5. Use Slim/Distroless Base Images

- Node.js: `node:22-slim` or `node:22-alpine` instead of `node:22`
- Python: `python:3.13-slim` instead of `python:3.13`
- Go/Rust: `distroless/static` or `scratch` for static binaries
- Java: `eclipse-temurin:21-jre-alpine` (JRE only, not JDK)

## 6. Code Generation Before Build

If the project uses code generation (types, i18n, ORM schemas), run it before the build step:

```dockerfile
RUN bun x svelte-kit sync && bun run build
```

Without this, the build may fail due to missing generated files that exist locally but aren't in the Docker context.

## 7. Combine RUN Commands When Appropriate

Reduce layers by combining related commands, but don't combine across cache boundaries:

```dockerfile
# ✅ Good — single layer for related cleanup
RUN apt-get update && apt-get install -y --no-install-recommends curl \
    && rm -rf /var/lib/apt/lists/*

# ❌ Bad — combining install + build breaks caching
RUN npm ci && npm run build
```

## 8. Use --frozen-lockfile / --ci Flags

Always use deterministic install commands in Docker:
- npm: `npm ci` (not `npm install`)
- bun: `bun install --frozen-lockfile`
- yarn: `yarn install --frozen-lockfile`
- pnpm: `pnpm install --frozen-lockfile`
- poetry: `poetry install --no-interaction`
- uv: `uv sync --frozen`

This ensures reproducible builds and avoids lockfile updates inside the container.

## Quick Checklist

- [ ] `.dockerignore` exists and excludes `.git/`, dependencies, build outputs, docs, IDE files
- [ ] Dependency manifest copied and installed before source code
- [ ] COPY instructions ordered from least to most frequently changed
- [ ] Multi-stage build separates build tools from production image
- [ ] Slim/distroless base image for production stage
- [ ] Code generation runs before build command
- [ ] Deterministic install flags used (--frozen-lockfile, ci)
- [ ] No unnecessary files in final image
