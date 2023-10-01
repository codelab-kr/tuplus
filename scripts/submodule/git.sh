msg=$1 || msg;

if [[ -z "$msg" ]]; then
  msg="tuplus submodule update default commit message";
fi;

if [[ $(git status --porcelain) ]]; then \
 git add . && git commit -m "$msg" && git push && echo "$msg"; \
fi;