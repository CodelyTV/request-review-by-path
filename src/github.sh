#!/usr/bin/env bash

GITHUB_API_URI="https://api.github.com"
GITHUB_API_HEADER="Accept: application/vnd.github.v3+json"

github::get_commit_modified_files() {
  local -r commit_ref=$1
#  curl -sSL -H "Authorization: token $GITHUB_TOKEN" -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/repos/$GITHUB_REPOSITORY/commits/$commit_ref" | jq .files | jq -r ".[] | .filename"
  curl -sSL -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/repos/$GITHUB_REPOSITORY/commits/$commit_ref" | jq .files | jq -r ".[] | .filename"
}

github::get_file_contets() {
  local -r file_path=$1
#  curl -sSL -H "Authorization: token $GITHUB_TOKEN" -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/repos/$GITHUB_REPOSITORY/contents/$file_path" | jq .content
  curl -sSL -H "$GITHUB_API_HEADER" "$GITHUB_API_URI/repos/$GITHUB_REPOSITORY/contents/$file_path" | jq .content
}
