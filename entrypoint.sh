#!/bin/bash

GITHUB_PUSH_SECRET=$1
DOCKER_IMAGE_NAME=$2
DOCKER_IMAGE_TAG=$3
DOCKERFILE_PATH=$4
BUILD_CONTEXT=$5
BUILD_ONLY=$6
DOCKER_BUILD_ARGS=$7

# Login to GHCR
echo ${GITHUB_PUSH_SECRET} | docker login https://ghcr.io -u ${GITHUB_ACTOR} --password-stdin

# GITHUB_REPOSITORY is always org/repo syntax. Get the owner in case it is different than the actor (when working in an org)
GITHUB_OWNER=`echo ${GITHUB_REPOSITORY} | cut -d/ -f1`

# Set up full image with tag
IMAGE_ID=ghcr.io/${GITHUB_OWNER}/${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}
IMAGE_ID=$(echo ${IMAGE_ID} | tr '[A-Z]' '[a-z]')

# Format the docker build arguments
IFS='\n'
array=($DOCKER_BUILD_ARGS)
BUILD_ARGS=''
for element in "${array[@]}"
do
	if [ "$element" ];then
		BUILD_ARGS="$BUILD_ARGS --build-arg \"$element\""
	fi
done

# Build image
echo build -t ${IMAGE_ID} -f ${DOCKERFILE_PATH} ${BUILD_ARGS} ${BUILD_CONTEXT}
docker build -t ${IMAGE_ID} -f ${DOCKERFILE_PATH} ${BUILD_ARGS} ${BUILD_CONTEXT}

# Push image
if [ "$BUILD_ONLY" == "true" ]; then
	echo "skipping push"
else
	docker push ${IMAGE_ID}
fi
