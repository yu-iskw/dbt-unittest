#!/usr/bin/env bash
set -euo pipefail

INTEGRATION_TESTS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
COMPOSE_FILE="${INTEGRATION_TESTS_DIR}/docker-compose.postgres.yml"
CONTAINER_NAME="dbt-unittest-postgres"
WAIT_SECONDS="${POSTGRES_WAIT_TIMEOUT_SECONDS:-60}"

if [[ $# -eq 0 ]]; then
  echo "Usage: $0 <command> [args ...]" >&2
  exit 1
fi

if ! docker info >/dev/null 2>&1; then
  echo "Docker daemon is not reachable." >&2
  exit 1
fi

docker compose -f "${COMPOSE_FILE}" up -d postgres

cleanup() {
  local exit_code="$?"
  if [[ "${exit_code}" -ne 0 ]]; then
    docker compose -f "${COMPOSE_FILE}" logs --no-color postgres || true
  fi
  docker compose -f "${COMPOSE_FILE}" down --remove-orphans >/dev/null 2>&1 || true
  exit "${exit_code}"
}
trap cleanup EXIT

started_at="$(date +%s)"
while [[ "$(docker inspect --format '{{if .State.Health}}{{.State.Health.Status}}{{else}}{{.State.Status}}{{end}}' "${CONTAINER_NAME}" 2>/dev/null || true)" != "healthy" ]]; do
  if (( "$(date +%s)" - started_at >= WAIT_SECONDS )); then
    echo "Timed out waiting for Postgres after ${WAIT_SECONDS}s." >&2
    exit 1
  fi
  sleep 1
done

cd "${INTEGRATION_TESTS_DIR}"
"$@"
