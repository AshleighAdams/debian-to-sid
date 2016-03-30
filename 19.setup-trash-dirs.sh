#!/bin/bash

set -e

if [[ `id --user` != 0 ]]; then
	sudo "$0" $@
	exit $?
fi

pushd /mnt

for mount_point in `ls -1`; do
	if [[ ! -x "$mount_point/.Trash" ]]; then
		echo "setting up trash for /mnt/$mount_point"
		mkdir "$mount_point/.Trash"
		chmod 1777 "$mount_point/.Trash" # give it sticky bit (others can only modify their own)
	else
		echo "trash already set up for /mnt/$mount_point"
	fi
done

popd
