if [ ! -f ./status/1 ]; then
	echo "0" > ./status/1
fi

if [ `cat ./status/1` == "0" ]; then
	sudo apt install apt-p2p && echo "0.5" > ./status/1
fi

if [ `cat ./status/1` == "0.5" ]; then
	sudo cp 1.source.list.template /etc/apt/sources.list
	echo "1" > ./status/1
fi

if [ `cat ./status/1` == "1" ]; then
	echo "updating packages..."
	sudo apt update
	echo "2" > ./status/1
fi

if [ `cat ./status/1` == "2" ]; then
	echo "performing dist-upgrade"
	echo "2.5" > ./status/1
	sudo apt dist-upgrade -y && echo "3" > ./status/1
fi

if [ `cat ./status/1` == "2.5" ]; then
	echo "dist-upgrade halted, attempting to resume!"
	sudo apt -f install -y && echo "3" > ./status/1
fi

if [ `cat ./status/1` == "3" ]; then
	echo "4" > ./status/1
	echo "done; reboot when ready..."
fi

