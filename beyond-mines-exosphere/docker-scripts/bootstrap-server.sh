#!/usr/bin/env bash

# print id/gid
echo $(id)
echo "User ID: $(id -u minecraft)" && \
echo "Group ID: $(id -g minecraft)"


# Define source and target directories
SOURCE_DIR="/minecraft-unzipped/BM_Exosphere_2.0.2_server"
TARGET_DIR="/minecraft"

# Check if the target directory is empty
if [ ! "$(ls -A $TARGET_DIR)" ]; then
  echo "Target directory is empty. Copying files from $SOURCE_DIR to $TARGET_DIR..."
  cp -r "$SOURCE_DIR"/* "$TARGET_DIR"
else
  echo "Target directory is already populated. Skipping file copy."
fi

# Accept the EULA
echo "eula=true" > "$TARGET_DIR/eula.txt"

# Start the server
echo "Starting the Minecraft server..."
exec bash "$TARGET_DIR/start.sh"