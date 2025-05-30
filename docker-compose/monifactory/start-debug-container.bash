#!/bin/bash

VERSION=$(cat VERSION)

docker rm monifactory-debug -f

echo "Starting Monifactory container with version: $VERSION"

docker run \
  -it \
  --name monifactory-debug \
  --restart unless-stopped \
  --entrypoint "/bin/bash" \
  monifactory:$VERSION