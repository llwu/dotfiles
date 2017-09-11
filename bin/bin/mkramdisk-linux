#!/bin/bash
ramfs_size_mb=1024m
mount_point=~/ramdisk
mkdir "$mount_point"
sudo mount -t tmpfs -o size=$ramfs_size_mb tmpfs "$mount_point"

echo "remove with:"
echo "umount ${mount_point}"
