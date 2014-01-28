status="./status/7"
if [ ! -f $status ]; then
	echo "0" > $status
fi

if [ `cat $status` == "0" ]; then
	echo "installing guake"
	sudo apt-get install -y guake && echo "1" > $status
fi

if [ `cat $status` == "1" ]; then
	# ['<Super>Above_Tab', '<Alt>Above_Tab']
	echo "adjusting org.gnome.desktop.wm.keybindings.switch-group"
	gsettings set org.gnome.desktop.wm.keybindings switch-group "['<Super>Above_Tab']"
	# ['<Super>Above_Tab']
	
	#guake-prefs
	echo "binding guake to alt+\`"
	gconftool-2 --set "/apps/guake/keybindings/global/show_hide" --type string "<Alt>grave"
	
	echo "2" > $status
fi

if [ `cat $status` == "2" ]; then
	echo "done"
fi
