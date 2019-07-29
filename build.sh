#!/bin/bash

: ${OCI_REG:="docker.io"}
: ${REPO_NAME:="kniec"}
: ${DD_SOURCE:="zero"}
: ${IMG_TAG_PREFIX:="zero"}

## First iteration
#docker build -t ${OCI_REG}/${REPO_NAME}/plain-size-test:${IMG_TAG_PREFIX}-0 \
#    --build-arg=FILENR=0 \
#    --build-arg=DD_SOURCE=${DD_SOURCE} \
#    --build-arg=FROM_IMG_REPO=library \
#    .
#docker push ${OCI_REG}/${REPO_NAME}/plain-size-test:${IMG_TAG_PREFIX}-0
#for x in {1..10};do
for x in ;do
    docker build -t ${OCI_REG}/${REPO_NAME}/plain-size-test:${IMG_TAG_PREFIX}-${x} \
        --build-arg=FILENR=${x} \
        --build-arg=DD_SOURCE=${DD_SOURCE} \
        --build-arg=DOCKER_REGISTRY=${OCI_REG} \
        --build-arg=FROM_IMG_REPO=${REPO_NAME} \
        --build-arg=FROM_IMG_NAME=plain-size-test \
        --build-arg=FROM_IMG_TAG=${IMG_TAG_PREFIX}-$((${x}-1)) \
        .
    docker push ${OCI_REG}/${REPO_NAME}/plain-size-test:${IMG_TAG_PREFIX}-${x}
done

if [[ "X${1}" == "Xsquash" ]];then
    docker build -t ${OCI_REG}/${REPO_NAME}/plain-size-test:${IMG_TAG_PREFIX}-squashed \
        -f=Dockerfile.squash \
        --build-arg=DD_SOURCE=${DD_SOURCE} \
        --build-arg=DOCKER_REGISTRY=${OCI_REG} \
        --build-arg=FROM_IMG_REPO=${REPO_NAME} \
        --build-arg=FROM_IMG_NAME=plain-size-test \
        --build-arg=FROM_IMG_TAG=${IMG_TAG_PREFIX}-10 \
        .
    docker push ${OCI_REG}/${REPO_NAME}/plain-size-test:${IMG_TAG_PREFIX}-squashed
fi

