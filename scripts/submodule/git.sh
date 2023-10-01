#!/bin/bash

msg=$@

if [[ -z "$msg" ]]; then
  echo "Error: commit message not provided"
  exit 1
fi;


# echo "======== Submodule Repo Update ========"
# git submodule foreach --recursive \
# "if [[ \$(git status --porcelain) ]]; then \
#   commit_msg=\"\$@\" && echo \"\$commit_msg\" \
#   git add . && git commit -m \"\$commit_msg\" && git push && echo \"\$commit_msg\"; \
# fi;" "$(echo "$msg")" || :

echo "======== Submodule Repo Update ========"
git submodule foreach --recursive \
'if [[ $(git status --porcelain) ]]; then \
  commit_msg=$@ && echo "commit_msg: $commit_msg" && \
  git add . && git commit -m "$commit_msg" && git push; \
fi;' || :

echo "\n======== Main Repo Update ========"
if [[ $(git status --porcelain) ]]; then \
  git add . && git commit -m "$@" && git push; \
fi || :