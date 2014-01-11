status="./status/4"
if [ ! -f $status ]; then
	echo "0" > $status
fi

if [ `cat $status` == "0" ]; then
	sudo apt-get install -y chromium quassel-core quassel-client pidgin pidgin-otr gnome-shell-extension-weather build-essential monodevelop vlc nemo git git-gui qbittorrent && echo "1" > $status
	xdg-mime default qBittorrent.desktop x-scheme-handler/magnet
fi

if [ `cat $status` == "1" ]; then
	echo "installing Steam pidgin plugin"
	mkdir ~/.purple
	mkdir ~/.purple/plugins
	cd ~/.purple/plugins
		wget https://github.com/seishun/SteamPP/releases/download/purple-v6/libsteam_ubuntu13.04_64.zip
		unzip libsteam_ubuntu13.04_64.zip
		rm libsteam_ubuntu13.04_64.zip
	cd -
	echo "installing pidgin-gnome-keyring plugin"
	wget https://pidgin-gnome-keyring.googlecode.com/files/pidgin-gnome-keyring_1.18-1_amd64.deb
	sudo dpkg -i pidgin-gnome-keyring_1.18-1_amd64.deb
	rm pidgin-gnome-keyring_1.18-1_amd64.deb
	echo "2" > $status
fi

if [ `cat $status` == "2" ]; then
	echo "setting nemo as default file manager"
	xdg-mime default nemo.desktop inode/directory application/x-gnome-saved-search
	echo "3" > $status
fi

if [ `cat $status` == "3" ]; then
	echo "installing Dropbox"
	wget https://www.dropbox.com/download?dl=packages/debian/dropbox_1.6.0_amd64.deb
	sudo dpkg -i *dropbox_1.6.0_amd64.deb
	sudo apt-get -f install
	rm *dropbox_1.6.0_amd64.deb
	echo "4" > $status
fi

if [ `cat $status` == "4" ]; then
	echo "done"
fi
