#!/bin/bash
#
#  Copyright (c) 2026 Martin Jablečník
#  Authors: Martin Jablečník
#  Description: Script for installing Kiro configuration to the default path (~/.kiro)
#
#

set -euo pipefail

SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
SOURCE_DIR="${SCRIPT_DIR}/local-configs/.kiro"
TARGET_DIR="${HOME}/.kiro"

if [[ ! -d "${SOURCE_DIR}" ]]; then
  echo "ERROR: Source directory '${SOURCE_DIR}' not found."
  exit 1
fi

echo "Installing Kiro configuration..."
echo "  Source: ${SOURCE_DIR}"
echo "  Target: ${TARGET_DIR}"

cp -r "${SOURCE_DIR}/." "${TARGET_DIR}/"

echo ""
echo "Done. Kiro configuration installed to ${TARGET_DIR}"
