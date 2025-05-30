#!/usr/bin/env bash

VERSION_FILE=VERSION
if [ ! -f "$VERSION_FILE" ]; then
  echo "Version file not found!"
  exit 1
fi
VERSION=$(cat "$VERSION_FILE")

echo "Building Monifactory container with version: $VERSION"
docker build --progress=plain -t monifactory:$VERSION ./