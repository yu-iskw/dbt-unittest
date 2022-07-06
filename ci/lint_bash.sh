#!/bin/bash
set -e

# The script validates bash scripts.

# Constants
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

shellcheck "${PROJECT_DIR}"/ci/*.sh
