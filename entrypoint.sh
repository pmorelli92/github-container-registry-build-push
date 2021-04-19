#!/bin/sh

PERSONAL_ACCESS_TOKEN=$1
DOCKER_IMAGE_NAME=$2
DOCKER_IMAGE_TAG=$3
DOCKERFILE_PATH=$4
BUILD_CONTEXT=$5

# Login to GHCR
echo ${PERSONAL_ACCESS_TOKEN} | docker login https://ghcr.io -u ${GITHUB_ACTOR} --password-stdin

GITHUB_OWNER=`echo ${GITHUB_REPOSITORY} | cut -d/ -f1`

# Set up full image with tag
IMAGE_ID=ghcr.io/${GITHUB_OWNER}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
IMAGE_ID=$(echo ${IMAGE_ID} | tr '[A-Z]' '[a-z]')

#TODO REMOVE
echo build -t ${IMAGE_ID} -f ${DOCKERFILE_PATH} ${BUILD_CONTEXT}
# Build image
docker build -t ${IMAGE_ID} -f ${DOCKERFILE_PATH} ${BUILD_CONTEXT}

# Push image
docker push ${IMAGE_ID}
