#!/bin/bash
set -e

# Constants
INTEGRATION_TESTS_DIR="$(dirname "$(readlink -f "$0")")"

# Default values
dbt_profiles_dir="${INTEGRATION_TESTS_DIR}/profiles"
dbt_target="postgres"

# Parse options and arguments
while (($# > 0)); do
  if [[ "$1" == "--profiles-dir" ]]; then
    dbt_profiles_dir="${2}"
    shift 2
  elif [[ "$1" == "--target" ]]; then
    dbt_target="${2}"
    shift 2
  fi
done

dbt deps --profiles-dir "${INTEGRATION_TESTS_DIR}/profiles" --target "${dbt_target:?}"

# Unit tests
dbt run-operation test_macros \
    --profiles-dir "${dbt_profiles_dir}" \
    --target "${dbt_target:?}"

# Verify that assertion failures use a supplied custom message.
if output=$(dbt run-operation test_assert_custom_message \
    --profiles-dir "${dbt_profiles_dir}" \
    --target "${dbt_target:?}" 2>&1); then
  echo "Expected custom message test to fail"
  exit 1
fi

if ! grep -Fq "Custom assertion message" <<<"${output}"; then
  echo "Custom assertion message was not included in the failure output"
  echo "${output}"
  exit 1
fi
