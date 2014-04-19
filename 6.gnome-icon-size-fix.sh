status="./status/6"
if [ ! -f $status ]; then
	echo "0" > $status
fi

if [ `cat $status` == "0" ]; then
	echo "fixing gnome icon size"
	cp /usr/share/gnome-shell/js/ui/messageTray.js /tmp/messageTray.js
	cp /usr/share/gnome-shell/theme/gnome-shell.css /tmp/gnome-shell.css
	sudo su -c 'cat /tmp/messageTray.js | sed "s/SOURCE_ICON_SIZE: 48,/SOURCE_ICON_SIZE: 24,/g" > /usr/share/gnome-shell/js/ui/messageTray.js'
	sudo su -c 'cat /tmp/gnome-shell.css | sed "s/background\\-repeat: repeat;\
    height: 72px;/background-position: 0 0;\
    background\\-repeat: repeat;\
    height: 48px;/g" > /usr/share/gnome-shell/theme/gnome-shell.cs'
	
fi

if [ `cat $status` == "1" ]; then
	echo "done"
fi
