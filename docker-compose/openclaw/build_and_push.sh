#!/bin/bash

# Configuration - can be overridden via environment variable GITHUB_USER
# Default kept for backwards compatibility; set GITHUB_USER in the environment to override
GITHUB_USER="${GITHUB_USER:-p2mb2}"
IMAGE_NAME="openclaw-custom"
TAG="latest"

# Ensure script stops on first error
set -e

echo "Building custom OpenClaw image..."
echo "User: $GITHUB_USER"
echo "Image: ghcr.io/$GITHUB_USER/$IMAGE_NAME:$TAG"

# 1. Build the Docker image
docker build -t ghcr.io/$GITHUB_USER/$IMAGE_NAME:$TAG .

# 2. Push to GitHub Container Registry (GHCR)
echo "--------------------------------------------------------"
echo "To push, you must be logged in to GHCR."
echo "If not logged in, run: echo \$CR_PAT | docker login ghcr.io -u $GITHUB_USER --password-stdin"
echo "where CR_PAT is your Personal Access Token with 'write:packages' scope."
echo "--------------------------------------------------------"
if [[ "${AUTO_PUSH}" == "true" ]]; then
    echo "AUTO_PUSH=true — pushing without prompt"
    docker push ghcr.io/$GITHUB_USER/$IMAGE_NAME:$TAG
    echo "Successfully pushed to ghcr.io/$GITHUB_USER/$IMAGE_NAME:$TAG"
else
    read -p "Do you want to push the image now? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        docker push ghcr.io/$GITHUB_USER/$IMAGE_NAME:$TAG
        echo "Successfully pushed to ghcr.io/$GITHUB_USER/$IMAGE_NAME:$TAG"
    else
        echo "Skipping push. You can push manually with:"
        echo "docker push ghcr.io/$GITHUB_USER/$IMAGE_NAME:$TAG"
    fi
fi
