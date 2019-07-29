ARG DOCKER_REGISTRY=docker.io
ARG FROM_IMG_REPO=qnib
ARG FROM_IMG_NAME="alpine"
ARG FROM_IMG_TAG="latest"
FROM ${DOCKER_REGISTRY}/${FROM_IMG_REPO}/${FROM_IMG_NAME}:${FROM_IMG_TAG}

ARG FILENR=1
ARG DD_SOURCE=zero
WORKDIR /data
RUN dd if=/dev/${DD_SOURCE} of=file_${FILENR}.txt count=1024 bs=1MB