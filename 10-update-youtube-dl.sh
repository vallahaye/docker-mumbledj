#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

youtube-dl -U >/dev/null 2>&1 || true
echo >&3 "$0: updated YouTube-dl to version $(youtube-dl --version)"

exit 0
