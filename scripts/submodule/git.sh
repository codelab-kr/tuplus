#!/bin/bash

msg=$1 

if [[ -z "$msg" ]]; then
  echo "Commit message is required"
  exit 1
fi;

# submodule repo update
echo "======== Submodule repo update ========"
git submodule foreach --recursive \
'if [[ $(git status --porcelain) ]]; then \
  commit_msg="$@" && echo "$commit_msg" && \
  git add . && git commit -m "$commit_msg" && git push && echo "$commit_msg"; \
fi;' $msg;

echo "======== Main repo update ========"
# main repo update
if [[ $(git status --porcelain) ]]; then \
  git add . && git commit -m "$msg" && git push && echo "$msg"; \
fi;