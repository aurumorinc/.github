#!/bin/bash
set -e

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <tag>"
    echo "Example: $0 latest"
    exit 1
fi

TAG=$1
IMAGE_NAME="ghcr.io/aurumorinc/llm-action-release"
IMAGE_TAG="${IMAGE_NAME}:${TAG}"
IMAGE_LATEST="${IMAGE_NAME}:latest"
DOCKERFILE="images/llm-action-release/Dockerfile"

if [ ! -f "$DOCKERFILE" ]; then
    echo "Error: $DOCKERFILE does not exist."
    exit 1
fi

echo "🚀 Building image ${IMAGE_TAG} using ${DOCKERFILE}..."
docker build -f "${DOCKERFILE}" -t "${IMAGE_TAG}" -t "${IMAGE_LATEST}" .

echo "✅ Successfully built ${IMAGE_TAG} and ${IMAGE_LATEST}"
