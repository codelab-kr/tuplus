#!/bin/bash

msg=$1 

if [[ -z "$msg" ]]; then
  echo "msg is empty"
  exit 1
fi;

echo "msg: $msg"

# $1이 존재할 경우에만 잘 실행되고 그렇지 않으면 command not found 에러가 발생한다.
# git submodule foreach --recursive \
# 'if [[ $(git status --porcelain) ]]; then \
#   commit_msg="$@" && echo "$commit_msg" && \
#   git add . && git commit -m "$commit_msg" && git push && echo "$commit_msg"; \
# fi;' $msg;


git submodule foreach --recursive \
'if [[ $(git status --porcelain) ]]; then \
  commit_msg="$@" && echo "$commit_msg" && \
  git add . && git commit -m "$commit_msg" && git push && echo "$commit_msg"; \
fi;' $msg;


if [[ $(git status --porcelain) ]]; then \
  git add . && git commit -m "$msg" && git push && echo "$msg"; \
fi;