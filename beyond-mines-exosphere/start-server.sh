#!/usr/bin/env bash

# Set variables
DATA_DIR="./minecraft-data"
CONTAINER_NAME="beyondminesexosphere"
IMAGE_NAME="beyondminesexosphere:2.0.2"
DETACHED_MODE=false

# Parse command-line arguments
for arg in "$@"; do
  case $arg in
    --detached)
      DETACHED_MODE=true
      shift
      ;;
    *)
      echo "Unknown argument: $arg"
      exit 1
      ;;
  esac
done

# Create the data directory if it doesn't exist
if [ ! -d "$DATA_DIR" ]; then
  mkdir -p "$DATA_DIR"
fi

# Ensure the data directory has the correct permissions
# Replace 1000:1000 with the UID:GID of the non-root user in the container
sudo chown -R 1001:1001 "$DATA_DIR"

# Check if a container with the same name already exists
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
  echo "Container with name '${CONTAINER_NAME}' already exists."

  # Check if the container is running
  if [ "$(docker inspect -f '{{.State.Running}}' "$CONTAINER_NAME")" == "true" ]; then
    echo "Container is already running."
    exit 0
  else
    echo "Removing the existing stopped container..."
    docker rm "$CONTAINER_NAME"
  fi
fi

# Run a new Docker container with the correct mounts and port mapping
echo "Creating and starting a new container..."
if [ "$DETACHED_MODE" = true ]; then
  docker run \
    --detach \
    --mount type=bind,source="$(pwd)/$DATA_DIR",target=/minecraft/ \
    --name "$CONTAINER_NAME" \
    --user 1001:1001 \
    -p 25565:25565 \
    "$IMAGE_NAME"
else
  docker run \
    --interactive \
    --tty \
    --mount type=bind,source="$(pwd)/$DATA_DIR",target=/minecraft/ \
    --name "$CONTAINER_NAME" \
    --user 1001:1001 \
    -p 25565:25565 \
    "$IMAGE_NAME"
fi