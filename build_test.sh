#! /bin/bash
IMAGE_VERSION=$(date '+%d%m%y')
docker build -t gm088/cserver:${IMAGE_VERSION} -t gm088/cserver:latest . && \
docker push gm088/cserver:${IMAGE_VERSION}
docker push gm088/cserver:latest
