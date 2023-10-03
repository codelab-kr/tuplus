export DOCKER_BUILDKIT=0

# docker-compose
if docker-compose ps > /dev/null; then
  docker-compose down -v --remove-orphans
fi

if [[ $1 && "$1" -eq "dev" ]]; then
  docker-compose -f docker-compose.dev.yaml up --build
else
  docker-compose up --build
fi

