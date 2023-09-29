#
# Builds a Docker image.
#
# Environment variables:
#
#   CONTAINER_REGISTRY - The hostname of your container registry.
#   VERSION - The version number to tag the images with.
#   NAME - The name of the image to build.
#   DIRECTORY - The directory form which to build the image.
#
# Usage:
#
#       ./scripts/cd/build-image-oci.sh
#

set -u # or set -o nounset
: "$CONTAINER_REGISTRY"
: "$VERSION"
: "$NAME"
: "$DIRECTORY"
: "$OCI_CONFIG"
: "$OCI_CLI_KEY_CONTENT"
: "$NAMESPACE"
: "$BUCKET_NAME"

docker buildx build --push --platform linux/arm64 --build-arg OCI_CONFIG="${OCI_CONFIG}" --build-arg OCI_CLI_KEY_CONTENT="${OCI_CLI_KEY_CONTENT}" --build-arg NAMESPACE="${NAMESPACE}" --build-arg BUCKET_NAME="${BUCKET_NAME}" --tag $CONTAINER_REGISTRY/$NAME:$VERSION --file ./$DIRECTORY/Dockerfile-prod ./$DIRECTORY
