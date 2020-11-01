#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

if [[ -z "${MUMBLEDJ_ENTRYPOINT_QUIET_LOGS:-}" ]]; then
  exec 3>&1
else
  exec 3>/dev/null
fi

if [[ "${1:0:1}" = "-" ]]; then
  set -- "mumbledj" "$@"
fi

_MUMBLEDJ_PRINT_INFO=0
for arg in "${@:2}"; do
  case "$arg" in
    -h|--help|-v|--version)
      _MUMBLEDJ_PRINT_INFO=1
      break
      ;;
  esac
done

if [[ "$1" = "mumbledj" && "$_MUMBLEDJ_PRINT_INFO" -eq 0 ]]; then
  # shellcheck disable=SC2034
  if find "/docker-entrypoint.d/" -maxdepth 0 -empty | read -r dummy; then
    echo >&3 "$0: no file found in /docker-entrypoint.d/, skipping configuration"
  else
    echo >&3 "$0: looking for shell scripts in /docker-entrypoint.d/"
    find "/docker-entrypoint.d/" -name '*.sh' -executable -follow -print | sort -n | while read -r file; do
      echo >&3 "$0: executing $file"
      "$file"
    done 
    echo >&3 "$0: configuration complete, ready for start up"
  fi
fi

exec "$@"
