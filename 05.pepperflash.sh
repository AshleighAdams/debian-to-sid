status="./status/5"
if [ ! -f $status ]; then
	echo "0" > $status
fi

if [ `cat $status` == "0" ]; then
	sudo apt-get install -y pepperflashplugin-nonfree && echo "1" > $status
fi

if [ `cat $status` == "1" ]; then
	echo "done; disable the old plugin in chrome on about:plugins"
fi
