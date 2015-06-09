if [ ! -f ./status/1 ]; then
	echo "0" > ./status/1
fi

if [ `cat ./status/1` == "0" ]; then
	mirror="http://httpredir.debian.org/debian"

	# if cancel pushed, exit
	[ $? == "1" ] && exit 1
	
	sudo cp 1.source.list.template /etc/apt/sources.list
	sudo sed "s|MIRROR|$mirror|g" --in-place=".bak" /etc/apt/sources.list
	
	echo "1" > ./status/1
fi

if [ `cat ./status/1` == "1" ]; then
	echo "updating packages..."
	sudo apt-get update
	echo "2" > ./status/1
fi

if [ `cat ./status/1` == "2" ]; then
	echo "performing dist-upgrade"
	echo "2.5" > ./status/1
	sudo apt-get dist-upgrade -y && echo "3" > ./status/1
fi

if [ `cat ./status/1` == "2.5" ]; then
	echo "dist-upgrade halted, attempting to resume!"
	sudo apt-get -f install -y && echo "3" > ./status/1
fi

if [ `cat ./status/1` == "3" ]; then
	echo "4" > ./status/1
	echo "done; rebooting..."
	sudo reboot
	exit
fi

if [ `cat ./status/1` == "4" ]; then
	echo "done!"
fi
