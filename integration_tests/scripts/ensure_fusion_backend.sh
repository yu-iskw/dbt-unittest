#!/usr/bin/env bash
set -euo pipefail

fusion_bin_dir="${DBT_FUSION_BIN_DIR:-}"
fusion_binary_name="${DBT_FUSION_BINARY_NAME:-dbt}"
fusion_version="${DBT_FUSION_VERSION:-}"
fusion_binary_path=""
install_runtime=0
verify_runtime=0

while (($# > 0)); do
  case "$1" in
    --install-runtime) install_runtime=1; shift ;;
    --verify-runtime) verify_runtime=1; shift ;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done

if [[ -n "${fusion_bin_dir}" ]]; then
  fusion_binary_path="${fusion_bin_dir%/}/${fusion_binary_name}"
fi

if ((install_runtime)); then
  if [[ -z "${fusion_binary_path}" ]]; then
    echo "DBT_FUSION_BIN_DIR must be set when installing dbt Fusion." >&2
    exit 1
  fi
  mkdir -p "${fusion_bin_dir}"
  install_home="$(mktemp -d)"
  trap 'rm -rf "${install_home}"' EXIT

  install_args=(--to "${fusion_bin_dir}")
  if [[ -n "${fusion_version}" ]]; then
    install_args+=(--version "${fusion_version}")
  else
    install_args+=(--update)
  fi

  HOME="${install_home}" ZDOTDIR="${install_home}" \
    bash -c 'curl -fsSL https://public.cdn.getdbt.com/fs/install/install.sh | bash -s -- "$@"' -- "${install_args[@]}"
fi

if ((verify_runtime)); then
  if [[ ! -x "${fusion_binary_path}" ]]; then
    echo "dbt Fusion binary was not found at ${fusion_binary_path}." >&2
    exit 1
  fi
  "${fusion_binary_path}" --version
fi
