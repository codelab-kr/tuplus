#!/bin/bash

msg=$@

if [[ -z "$msg" ]]; then
  echo "Commit message is required"
  exit 1
fi;

echo "======== Submodule Repo Update ========"
git submodule foreach --recursive \
'if [[ $(git status --porcelain) ]]; then \
  commit_msg="$@" && echo "$commit_msg" && \
  git add . && git commit -m "$commit_msg" && git push; \
fi;' $msg;

echo "\n======== Main Repo Update ========"
if [[ $(git status --porcelain) ]]; then \
  git add . && git commit -m "$msg" && git push; \
fi || :; 