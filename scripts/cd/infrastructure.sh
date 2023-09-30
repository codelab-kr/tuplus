#
# Deploy infrastrucgture
#
# Usage:
#
#   ./scripts/cd/infrastructure.sh
#

kubectl -n tuplus apply -f ./scripts/cd/rabbit.yaml
kubectl -n tuplus apply -f ./scripts/cd/mongodb.yaml
