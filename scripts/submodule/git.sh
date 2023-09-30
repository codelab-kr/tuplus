# git submodule foreach 'echo $path $var' -- $var='test'


git submodule foreach -q \
'if [[ $(git status --porcelain) ]]; then \
  git add . | 2>/dev/null && git commit -m "$msg" && git push && echo "$path git"; \
fi;'$1 || :

if [[ $(git status --porcelain) && $1 ]]; then \
  git add . && git commit -m "$1" && git push && echo "tuplus git add & commit & push"; \
fi;

# then git add . | 2>/dev/null && git commit -m $msg && git push; \

# git submodule foreach \
# 'if [[ $(git status --porcelain) && $var ]]; \
#   then echo "$path $var"; \
# fi;' -- $var=test


# git submodule foreach --recursive '[[ "$name" = *"foo"* ]] && \
#      ( echo $path; echo "paths+=($path)" >> /tmp/paths ) || true'
# source /tmp/paths
# rm /tmp/paths
# echo ${paths[@]}

# git submodule foreach --recursive "git checkout $user_branch" | while read -r path; do
#   echo $path
# done

# git submodule foreach -q --recursive 'branch="$(git config -f $toplevel/.gitmodules submodule.$name.branch)"; \
#   if [[ "$branch" = "master" ]]; \
#   then echo $path; \
#   fi;' | while read -r path; do
#     echo $path
#   done

git submodule foreach 'echo "$msg"' $1