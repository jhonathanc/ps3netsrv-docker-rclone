#!/bin/bash
set -e

REMOTE=${RCLONE_REMOTE:-onedrive:/PS3}
MOUNT_DIR=/data

echo "Mounting OneDrive..."

rclone mount "$REMOTE" "$MOUNT_DIR" \
  --config "$RCLONE_CONFIG" \
  --allow-other \
  --vfs-cache-mode full \
  --vfs-cache-max-size 20G \
  --buffer-size 128M \
  --dir-cache-time 1000h \
  --poll-interval 0 \
  --cache-dir /cache &

sleep 5

echo "Starting ps3netsrv..."
exec ps3netsrv "$MOUNT_DIR"
