#!/bin/bash

msg=$1
echo "msg: $msg"

if [[ -z "$msg" ]]; then
  msg="tuplus submodule update default commit message";
fi;

git submodule foreach \
'if [[ $(git status --porcelain) ]]; then \
    git add . && git commit -m $msg && git push && echo $msg; \
fi;' || :

if [[ $(git status --porcelain) ]]; then \
  git add . && git commit -m "$msg" && git push && echo "$msg"; \
fi;