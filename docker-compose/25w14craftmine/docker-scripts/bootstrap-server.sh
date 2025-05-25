#!/usr/bin/env bash

# print id/gid
echo $(id)
echo "User ID: $(id -u minecraft)" && \
echo "Group ID: $(id -g minecraft)"

# Define source and target directories
SOURCE_DIR="/minecraft-unzipped" 
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

# Start the server as the minecraft user
echo "Changing ownership of $TARGET_DIR to user 'minecraft'..."
chown -R minecraft:minecraft "$TARGET_DIR"

echo "Setting permissions for $TARGET_DIR..."
chmod -R 755 "$TARGET_DIR"

# print useful info and sleep
ls -lash /minecraft
echo "Sleeping for 5 seconds to allow for debugging..."
sleep 5

echo "Starting the server as the minecraft user..."
# Switch to the minecraft user and execute the start script
exec su -c "java -jar server.jar" minecraft