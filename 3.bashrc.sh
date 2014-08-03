status="./status/3"
if [ ! -f $status ]; then
	echo "0" > $status
fi

if [ `cat $status` == "0" ]; then
	wget https://raw.github.com/KateAdams/.bashrc/master/.bashrc
	cp ~/.bashrc .bashrc.original
	mv .bashrc ~/.bashrc
	sudo apt-get install trash-cli
fi

if [ `cat $status` == "1" ]; then
	echo "done"
fi
