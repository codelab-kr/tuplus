#
# Remove containers from Kubernetes.
#
# Usage:
#
#   cd ./scripts/production-kub 
#   ./delete.sh
#

kubectl -n tuplus delete -f rabbit.yaml
kubectl -n tuplus delete -f mongodb.yaml
envsubst <metadata.yaml | kubectl -n tuplus delete -f -
envsubst <history.yaml | kubectl -n tuplus delete -f -
# envsubst <mock-storage.yaml | kubectl -n tuplus delete -f -
envsubst <oci-storage.yaml | kubectl -n tuplus delete -f -
envsubst <video-streaming.yaml | kubectl -n tuplus delete -f -
envsubst <video-upload.yaml | kubectl -n tuplus delete -f -
envsubst <gateway.yaml | kubectl -n tuplus delete -f -

kubectl -n tuplus delete secret ocir-registry-secret 