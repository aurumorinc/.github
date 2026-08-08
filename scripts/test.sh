#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <image_dir_name> <tag>"
    echo "Example: $0 llm-action-release latest"
    exit 1
fi

IMAGE=$1
TAG=$2
IMAGE_NAME="ghcr.io/aurumorinc/${IMAGE}:${TAG}"
GOSS_FILE="images/${IMAGE}/goss.yaml"

if [ ! -f "$GOSS_FILE" ]; then
    echo "⚠️  No goss.yaml found for ${IMAGE} at ${GOSS_FILE}. Skipping tests."
    exit 0
fi

BIN_DIR="./.bin"
mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$PATH"

GOSS_VERSION="v0.4.8"

if ! command -v goss >/dev/null 2>&1; then
    echo "⬇️ Downloading goss ${GOSS_VERSION}..."
    curl -fsSL "https://github.com/goss-org/goss/releases/download/${GOSS_VERSION}/goss-linux-amd64" -o "$BIN_DIR/goss"
    chmod +rx "$BIN_DIR/goss"
fi

if ! command -v dgoss >/dev/null 2>&1; then
    echo "⬇️ Downloading dgoss ${GOSS_VERSION}..."
    curl -fsSL "https://github.com/goss-org/goss/releases/download/${GOSS_VERSION}/dgoss" -o "$BIN_DIR/dgoss"
    chmod +rx "$BIN_DIR/dgoss"
fi

echo "🧪 Running dgoss tests for image: ${IMAGE_NAME}..."

export GOSS_FILE="$GOSS_FILE"
export GOSS_OPTS="--max-concurrent 1"
dgoss run --entrypoint tail "$IMAGE_NAME" -f /dev/null

echo "✅ Tests passed for ${IMAGE}!"
