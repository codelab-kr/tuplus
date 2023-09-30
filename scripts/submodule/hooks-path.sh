# git submodule foreach 'echo ("$path" != "db-fixture-rest-api") && git config core.hooksPath ../.husky'
# git submodule foreach 'if [ "$path" != "db-fixture-rest-api" ]; (git config core.hooksPath ../.husky); fi;'

git submodule foreach \
'path=$(echo $path | cut -d/ -f2) && \
if [ "$path" != "db-fixture-rest-api" ]; \
then git config core.hooksPath ../.husky && \
echo "$path changed hooksPath to ../.husky"; \
fi;'