if [ ! -f ./status/2 ]; then
	echo "0" > ./status/2
fi

if [ `cat ./status/2` == "0" ]; then
	echo "adding i386 archutecutre"
	sudo dpkg --add-architecture i386
	sudo apt-get update
	echo "1" > ./status/2
fi

if [ `cat ./status/2` == "1" ]; then
	echo "1.5" > ./status/2
	echo "installing nvidia drivers"
	sudo apt-get install nvidia-kernel-dkms # -y
	
fi

if [ `cat ./status/2` == "1.5" ]; then
	contents='Section "Device"\n\tIdentifier "My GPU"\n\tDriver "nvidia"\n\tOption "NoLogo" "1"\n\tOption "RenderAccel" "1"\n\tOption "TripleBuffer" "true"\n\tOption "MigrationHeuristic" "greedy"\nEndSection'
	sudo mkdir /etc/X11/xorg.conf.d
	echo -e $contents > /tmp/20-nvidia.conf
	sudo cp /tmp/20-nvidia.conf /etc/X11/xorg.conf.d/20-nvidia.conf && echo "2" > ./status/2 || echo "WARNING!!!! COULD NOT INSTALL CONFIG, DO NOT REBOOT UNTIL DONE"
fi

if [ `cat ./status/2` == "2" ]; then
	echo "modifying .xinitrc"
	echo -e "\n#Improve performance on Mozila stuff\nnvidia-settings -a InitialPixmapPlacement=2 -a GlyphCache=1" >> ~/.xinitrc
	echo "3" > ./status/2
fi

if [ `cat ./status/2` == "3" ]; then
	sudo apt-get install nvidia-xconfig -y
	sudo nvidia-xconfig
	echo "please reboot."
fi
