#!/bin/bash

msg=$1
echo "msg: $msg"

if [[ -z "$msg" ]]; then
  msg="tuplus submodule update default commit message";
fi;

dd=`if [[ $(git status --porcelain) ]]; then \
  git add . && git commit -m "$msg" && git push && echo "$msg"; \
fi;`

git submodule foreach $(echo $dd) $msg

