#!/usr/bin/env bash
export REPO="./_cheatsheets"
export SINCE="$(cat _updated.txt)"
(
  cd "${REPO}"
  git log ${SINCE}..HEAD --pretty="" --name-only \
  | grep -E '\.md$' \
  | grep -v -E 'CONTRIBUTING|README|Readme' \
  | grep -v -E '^_' \
  | sort \
  | uniq \
  | sed 's/\.md$//g' \
) \
  | sed 's#^\(.*\)$#previews/\1.jpg#g' \
  | xargs echo PREVIEWS:
