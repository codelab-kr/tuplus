git submodule foreach \
'if [[ $(git status --porcelain) && $msg ]]; then \
  git add . | 2>/dev/null && git commit -m "$msg" && git push && echo "$path git add & commit & push"; \
fi;' -- $msg=$1

if [[ $(git status --porcelain) && $1 ]]; \
then git add . && git commit -m "$1" && git push && echo "tuplus git add & commit & push"; \
fi;