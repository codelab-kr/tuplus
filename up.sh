export DOCKER_BUILDKIT=0

# docker-compose
if docker-compose ps > /dev/null; then
  docker-compose down
fi

if [[ $1 && "$1" -eq "dev" ]]; then
  docker-compose -f docker-compose.dev.yaml up --build
else
  docker-compose up --build
fi

