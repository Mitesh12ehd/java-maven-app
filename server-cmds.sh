#!/user/bin/env bash

export IMAGE_NAME=$1

# docker login
export DOCKER_PASSWORD = $2
export DOCKER_USERNAME = $3
echo $DOCKER_PASSWORD | docker login -u $DOCKER_USERNAME --password-stdin

docker-compose -f docker-compose.yaml up --detach   