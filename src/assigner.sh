#!/usr/bin/env bash

assigner::directory_has_been_modified() {
  local -r directory=$1
  local -r modified_directories=$(github::get_commit_modified_files $GITHUB_SHA | grep "src/" | awk -F '/' '{print $2}' | uniq)

  log::message "modified_directories: "
  log::message "$modified_directories"

  [[ $modified_directories == *"$directory"* ]]
}

assigner::team_has_been_modified() {
  local -r IFS=$'\n'
  local -r team_directories=($1)
  local i
  for (( i=0; i<${#team_directories[@]}; i++ )) ; do
    local -r directory_without_yaml=$(echo "${team_directories[$i]//'- '}")

    if assigner::directory_has_been_modified "$directory_without_yaml" ; then
        log::message "👍 $directory_without_yaml directory HAS been modified"
    else
        log::message "👎 $directory_without_yaml directory has NOT been modified"
    fi
  done
}

assigner::assign_to() {
  local IFS=$'\n'
  local teams_mappings=($1)
  local i
  for (( i=0; i<${#teams_mappings[@]}; i++ )) ; do
    log::message "Team $i: ${teams_mappings[$i]}"

    log::message "---------------------------------"
    local -r team_directories=$(yq r -X monorepo_assign.yml "assign.${teams_mappings[$i]}")

    assigner::team_has_been_modified "$team_directories"

    log::message "---------------------------------"
  done
}

assigner::assign() {
  local -r teams_mappings=$(yq r monorepo_assign.yml assign | awk -F":" '{print $1}')
  assigner::assign_to "$teams_mappings"
}
