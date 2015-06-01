#!/bin/bash

set -e # error on a failed command

sudo apt-get build-dep gnome-terminal

sudo rm -rf /tmp/gt || true # make sure it's gone!
mkdir /tmp/gt

cp  13.gnome-terminal-restore-dark.patch /tmp/gt/gnome-terminal-restore-dark.patch

pushd /tmp/gt/
	apt-get source gnome-terminal

	echo "preparing patch..."

	mv `echo */` a/

	echo "applying patch..."
	ls
	patch -p0 < ./gnome-terminal-restore-dark.patch

	pushd a/
		echo "building..."
		touch configure.ac aclocal.m4 configure Makefile.am Makefile.in # else complains aclocal-1.13 not found
		./configure prefix=/usr/
		make
		sudo make install
	popd
popd
