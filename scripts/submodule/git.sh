git submodule foreach \
'path=$(echo $path | cut -d/ -f2); && \
if [[ $(git status --porcelain) ]]; \
then git add . && git commit -m "$1" && git push && echo "$path git add & commit & push"; \
fi;'

if [[ $(git status --porcelain) && $1 ]]; \
then git add . && git commit -m "$1" && git push && echo "tuplus git add & commit & push"; \
fi;