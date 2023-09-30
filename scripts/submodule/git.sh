msg=$(echo "$1")
echo "$msg"

git submodule foreach \
'if [[ $(git status --porcelain) ]]; then \
  git add . | 2>/dev/null && git commit -m $(echo "$1") && git push && echo "$path git add & commit & push"; \
fi;'

if [[ $(git status --porcelain) && $1 ]]; \
then git add . && git commit -m "$1" && git push && echo "tuplus git add & commit & push"; \
fi;