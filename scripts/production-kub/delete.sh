#
# Remove containers from Kubernetes.
#
# Usage:
#
#   cd ./scripts/production-kub 
#   ./delete.sh
#

kubectl -n tuflix delete -f rabbit.yaml
kubectl -n tuflix delete -f mongodb.yaml
envsubst <metadata.yaml | kubectl -n tuflix delete -f -
envsubst <history.yaml | kubectl -n tuflix delete -f -
# envsubst <mock-storage.yaml | kubectl -n tuflix delete -f -
envsubst <oci-storage.yaml | kubectl -n tuflix delete -f -
envsubst <video-streaming.yaml | kubectl -n tuflix delete -f -
envsubst <video-upload.yaml | kubectl -n tuflix delete -f -
envsubst <gateway.yaml | kubectl -n tuflix delete -f -

kubectl -n tuflix delete secret free-registry-secret 