#!/usr/bin/env bash
set -euo pipefail

ASSIGN_BY_PATH_HOME="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"

if [ "$ASSIGN_BY_PATH_HOME" == "/" ]; then
  ASSIGN_BY_PATH_HOME=""
fi

export ASSIGN_BY_PATH_HOME

bash --version

source "$ASSIGN_BY_PATH_HOME/src/main.sh"

main "$@"

exit $?
