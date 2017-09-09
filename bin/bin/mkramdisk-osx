#!/bin/bash
ramfs_size_mb=1024
mount_point=~/ramdisk

ramfs_size_sectors=$((${ramfs_size_mb}*1024*1024/512))
ramdisk_dev=`hdid -nomount ram://${ramfs_size_sectors}`
/sbin/newfs_hfs -v 'Ramdisk' ${ramdisk_dev}
mkdir -p ${mount_point}
/sbin/mount -o noatime -t hfs ${ramdisk_dev} ${mount_point}

echo "remove with:"
echo "umount ${mount_point}"
echo "diskutil eject ${ramdisk_dev}"
