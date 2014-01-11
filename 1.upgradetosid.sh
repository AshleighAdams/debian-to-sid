if [ ! -f ./status/1 ]; then
	echo "0" > ./status/1
fi

if [ `cat ./status/1` == "0" ]; then
	echo "making backup of sources.list"
	sudo cp /etc/apt/sources.list /etc/apt/sources.list.original
	cat /etc/apt/sources.list | grep "wheezy main" > /tmp/sources.list

	echo "adding unstable"
	echo "# Unstable" > /tmp/sources.list.final
	cat /tmp/sources.list | sed "s/wheezy/unstable/g" > /tmp/sources.list.unstable
	cat /tmp/sources.list.unstable >> /tmp/sources.list.final

	echo "adding experimental"
	echo "# Experimental" >> /tmp/sources.list.final
	cat /tmp/sources.list | sed "s/wheezy/experimental/g" > /tmp/sources.list.experimental
	cat /tmp/sources.list.experimental >> /tmp/sources.list.final

	echo "adding none-free, contrib, and others"
	cat /tmp/sources.list.final | sed "s/ main/ main none-free contrib/g" > /tmp/sources.list.final.1

	echo "installing new sources.list"
	sudo cp /tmp/sources.list.final.1 /etc/apt/sources.list

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
