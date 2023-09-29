#
# Deploy infrastrucgture
#
# Usage:
#
#   ./scripts/cd/infrastructure.sh
#

kubectl -n tuflix apply -f ./scripts/cd/rabbit.yaml
kubectl -n tuflix apply -f ./scripts/cd/mongodb.yaml
