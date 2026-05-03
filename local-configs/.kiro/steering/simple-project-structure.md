---
inclusion: always
---

# Simple Project Structure

## Scope

These rules apply to all non-UI projects: backend services, CLI tools, parsers, scrapers, workers, scripts, and any project without a graphical interface. They do NOT apply to the Flutter frontend, which follows `flutter-architecture.md`.

## Flat vs Folder Threshold

- Up to ~8 source files in a single directory: flat structure is acceptable
- Beyond ~8 files: organize into subdirectories by responsibility

## Standard Subdirectories

When organizing into folders, use these categories as needed:

- `core/` — configuration, types/schemas, constants, utilities, shared infrastructure
- `data/` — models, entities, DTOs, database schemas, value objects
- `clients/` — HTTP clients and external service integrations (pure I/O, no business logic)
- `services/` — business logic, orchestration, workflow handlers, command handlers

Not every project needs all four. Use only what makes sense for the project size.

## Entry Point

The main entry point (`index.ts`, `main.go`, `main.py`, etc.) stays in the root of the source directory.

## Single File = No Folder

If a subdirectory would contain only one file, don't create the directory. Use a single file instead.

- ❌ `core/config/config.ts`
- ✅ `core/config.ts`

## Scripts

Setup scripts, migrations, seeds, and CLI utilities go in `scripts/` at the project root, outside the source directory.

## Tests

- Tests go in a dedicated directory following the conventions of the language/framework
- Test directory structure mirrors the source directory structure
