#!/bin/bash

: ${OCI_REG:="docker.io"}
: ${REPO_NAME:="kniec"}

## First iteration
docker build -t ${OCI_REG}/${REPO_NAME}/plain-size-test:0 \
    --build-arg=FILENR=0 \
    --build-arg=FROM_IMG_REPO=library \
    .
docker push ${OCI_REG}/${REPO_NAME}/plain-size-test:0
for x in {1..10};do
    docker build -t ${OCI_REG}/${REPO_NAME}/plain-size-test:${x} \
        --build-arg=FILENR=${x} \
        --build-arg=DOCKER_REGISTRY=${OCI_REG} \
        --build-arg=FROM_IMG_REPO=${REPO_NAME} \
        --build-arg=FROM_IMG_NAME=plain-size-test \
        --build-arg=FROM_IMG_TAG=$((${x}-1)) \
        .
    docker push ${OCI_REG}/${REPO_NAME}/plain-size-test:${x}
done