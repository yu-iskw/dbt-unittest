#!/bin/bash
set -e

# The script validates YAML files.

# Constants
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

yamllint -s "${PROJECT_DIR}/dbt_project.yml"
yamllint -s "${PROJECT_DIR}/macros/"
