#!/bin/bash

if [ "$(id -u)" != "0" ]; then
	sudo $0 $@
	exit
fi

status="./status/6"
if [ ! -f $status ]; then
	echo "0" > $status
fi

if [ `cat $status` == "0" ]; then
	echo "extracting gnome's JS files"
	
	gs=/usr/lib/gnome-shell/libgnome-shell.so
	
	mkdir -p /usr/share/gnome-shell/js
	cd /usr/share/gnome-shell/js
	
	mkdir -p ui ui/components ui/status misc perf extensionPrefs gdm portalHelper

	for r in `gresource list $gs`; do
	  gresource extract $gs $r > ${r/#\/org\/gnome\/shell/.}
	done
	cd -
fi

if [ `cat $status` == "0" ]; then
	echo "fixing gnome icon size"
	cp /usr/share/gnome-shell/js/ui/messageTray.js /tmp/messageTray.js
	cp /usr/share/gnome-shell/theme/gnome-shell.css /tmp/gnome-shell.css
	cat /tmp/messageTray.js | sed "s/SOURCE_ICON_SIZE: 48,/SOURCE_ICON_SIZE: 24,/g" > /usr/share/gnome-shell/js/ui/messageTray.js
	cat /tmp/gnome-shell.css | sed "s|height: 72px;|background-position: 0 0;\
    background\\-repeat: repeat;\
    height: 48px;|g" > /usr/share/gnome-shell/theme/gnome-shell.css
fi

if [ `cat $status` == "0" ]; then
	echo "place 'export GNOME_SHELL_JS=/usr/share/gnome-shell/js' in your ~/.gnomerc"
	echo "done"
fi
