git submodule foreach \
'path=$(echo $path | cut -d/ -f2) && \
if [ "$path" != "security" ]; \
then npm install && git add . && git commit -m "update @types/node version" && git push && echo "$path push"; \
fi;'