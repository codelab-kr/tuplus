# docker-compose
if docker-compose ps > /dev/null; then
  docker-compose down -v --remove-orphans
fi