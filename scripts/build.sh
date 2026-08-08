#!/bin/bash
set -e

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <image_dir_name> <tag>"
    echo "Example: $0 llm-action-release latest"
    exit 1
fi

IMAGE=$1
TAG=$2

SCRIPT_PATH="images/${IMAGE}/scripts/build.sh"

if [ ! -f "$SCRIPT_PATH" ]; then
    echo "Error: $SCRIPT_PATH does not exist for IMAGE '$IMAGE'."
    exit 1
fi

# Execute the specific build script for the image
chmod +x "$SCRIPT_PATH" || true
bash ./$SCRIPT_PATH "$TAG"
