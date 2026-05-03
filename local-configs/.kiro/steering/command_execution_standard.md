---
inclusion: always
---

# Command Execution Standards

## Shell Environment

All shell commands must be compatible with **zsh** and executed in either:
- WSL (Windows Subsystem for Linux)
- Native Linux environment

## Generated Shell Scripts

When generating shell scripts (`.sh` files), the default shell MUST be **bash** (`#!/bin/bash`). All generated scripts should follow bash standards and best practices (e.g., `set -euo pipefail`).

Use zsh (`#!/usr/bin/env zsh`) ONLY when the user explicitly requests or permits it.

## Command Requirements

Commands should:
- Use POSIX-compliant syntax when possible
- Avoid bash-specific features unless absolutely necessary
- Be tested for zsh compatibility
- Work in both WSL and native Linux environments

## Common Pitfalls to Avoid

❌ Avoid:
- Windows-specific commands (e.g., `dir`, `copy`, `del`)
- PowerShell-specific syntax
- Bash-only features without zsh equivalents
- Hardcoded Windows paths (e.g., `C:\Users\...`)

✅ Use:
- Unix standard commands (e.g., `ls`, `cp`, `rm`, `mv`)
- POSIX-compliant path separators (`/`)
- Environment variables for paths when needed
- Commands that work across Unix-like systems

## Examples

✅ Good:
```bash
# List files
ls -la

# Remove directory
rm -rf build/

# Find files
find . -name "*.js"

# Environment variable
export NODE_ENV=production
```

❌ Bad:
```bash
# Windows CMD syntax
dir /s

# PowerShell syntax
Remove-Item -Recurse build

# Bash-only array syntax (if not zsh compatible)
declare -a array=("item1" "item2")
```

## Script Shebangs

For shell scripts, use:
```bash
#!/usr/bin/env zsh
```

Or for broader compatibility:
```bash
#!/bin/sh
```

## Note

When providing commands or creating scripts, always ensure they will execute correctly in a zsh shell running on WSL or Linux.
