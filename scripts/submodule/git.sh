msg=$1
echo "msg: $msg"
echo "COMMIT_MSG: $COMMIT_MSG"

msg=${COMMIT_MSG:-$msg}

echo "msg: $msg"

if [[ -z "$msg" ]]; then
  msg="tuplus submodule update default commit message";
fi;

if [[ $(git status --porcelain) ]]; then \
 git add . && git commit -m "$msg" && git push && echo "$msg"; \
fi;