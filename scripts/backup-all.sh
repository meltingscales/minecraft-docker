#!/usr/bin/env bash


# This script is used to backup all the minecraft-data folders and timestamp them.

BACKUP_SRC="~/Git/minecraft-docker/docker-compose/"
BACKUP_DEST="~/minecraft-backup/"
BACKUP_NAME="backup-$(date +%Y-%m-%d_%H-%M-%S).tar.gz"

# TODO finish the script
# TODO add a check to see if the backup destination exists
# TODO add a check to see if the backup source exists