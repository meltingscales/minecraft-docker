#!/usr/bin/env bash
set -euxo pipefail

# This script is used to backup all the minecraft-data folders and timestamp them.

BACKUP_SRC="~/Git/minecraft-docker/docker-compose/"
# expand backup source
BACKUP_SRC=$(eval echo "$BACKUP_SRC")

BACKUP_DEST="~/minecraft-backup/"
BACKUP_DEST=$(eval echo "$BACKUP_DEST")

BACKUP_NAME="backup-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

if [ ! -d "$BACKUP_DEST" ]; then
    echo "Backup destination does not exist. Creating it..."
    mkdir -p "$BACKUP_DEST"
fi

# set globbing mode to match directories
shopt -s nullglob

dirs="$BACKUP_SRC*/minecraft-data"
# loop over all minecraft-data folders
for dir in $dirs; do

    if [ -d "$dir" ]; then
        echo "Backing up $dir"

        # get name of the modpack
        MODPACK_NAME=$(basename "$(dirname "$dir")")
        
        # create a backup name with the modpack name
        BACKUP_NAME="backup-${MODPACK_NAME}-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"
        # create the backup
        sudo tar -czf "$BACKUP_DEST$BACKUP_NAME" -C "$dir" .
        sudo chown "$USER" "$BACKUP_DEST$BACKUP_NAME"
        echo "Backup created: $BACKUP_DEST$BACKUP_NAME"
    else
        echo "No minecraft-data directory found in $dir"
    fi
done