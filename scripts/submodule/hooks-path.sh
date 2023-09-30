git submodule foreach \
'path=$(echo $path | cut -d/ -f2) && \
if [ "$path" != "db-fixture-rest-api" ]; \
then git config core.hooksPath ../.husky && \
echo "$path changed hooksPath to ../.husky"; \
fi;'