#!/usr/bin/env bash

source "$ASSIGN_BY_PATH_HOME/src/assigner.sh"
source "$ASSIGN_BY_PATH_HOME/src/ensure.sh"
source "$ASSIGN_BY_PATH_HOME/src/github.sh"
source "$ASSIGN_BY_PATH_HOME/src/misc.sh"

main() {
  ensure::env_variable_exist "GITHUB_REPOSITORY"
  ensure::env_variable_exist "GITHUB_EVENT_PATH"
  ensure::env_variable_exist "GITHUB_SHA"
  ensure::total_args 1 "$@"

  export GITHUB_TOKEN="$1"

  assigner::assign

  exit $?
}
