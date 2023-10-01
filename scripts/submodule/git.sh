#!/bin/bash

msg=$@

if [[ -z "$msg" ]]; then
  echo "Error: commit message not provided"
  exit 1
fi;


# echo "======== Submodule Repo Update ========"
# git submodule foreach --recursive \
# 'if [[ $(git status --porcelain) ]]; then \
#   commit_msg=$@ && echo "commit_msg: $commit_msg" && \
#   git add . && git commit -m "$commit_msg" && git push; \
# fi;' || :


git submodule foreach --recursive \
'if ! [[ -z "$@" ]]; then \
  echo "arg is passed to the command $1"; \
else \
  echo "arg is not passed to the command"; \
fi;' "$@"

echo "\n======== Main Repo Update ========"
if [[ $(git status --porcelain) ]]; then \
  git add . && git commit -m "$@" && git push; \
fi || :