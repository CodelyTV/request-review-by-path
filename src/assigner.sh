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
  local -r all_team_paths=($1)
  local i
  for (( i=0; i<${#all_team_paths[@]}; i++ )) ; do
    local -r directory_without_yaml=$(echo "${all_team_paths[$i]//'- '}")

    if assigner::directory_has_been_modified "$directory_without_yaml" ; then
        log::message "👍 $directory_without_yaml directory HAS been modified"
    else
        log::message "👎 $directory_without_yaml directory has NOT been modified"
    fi
  done
}

assigner::assign_to() {
  local -r IFS=$'\n'
  local -r all_teams=($1)
  local -r teams_mappings=($2)
  local i
  for (( i=0; i<${#all_teams[@]}; i++ )) ; do
    log::message "Team $i: ${all_teams[$i]}"

    log::message "---------------------------------"
    local -r team_paths=$(echo "$teams_mappings" | yaml2json | jq "assign.${all_teams[$i]}")

    assigner::team_has_been_modified "$team_paths"

    log::message "---------------------------------"
  done
}

assigner::assign() {
  local -r assign_by_path_mappings_yml=$(github::get_file_contets "/.github/workflows/assign_by_path_mappings.yml")

  local -r teams=$(echo "$assign_by_path_mappings_yml" | yaml2json | jq .assign | awk -F":" '{print $1}')
  assigner::assign_to "$teams" "$assign_by_path_mappings_yml"
}
