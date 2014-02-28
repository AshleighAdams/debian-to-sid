status="`pwd`/status/8"
from="`pwd`"

if [ ! -f $status ]; then # clone it
	mkdir -p ~/.builds/
	from="`pwd`"
	cd ~/.builds
	
	echo "getting gqrx"
	git clone https://github.com/csete/gqrx.git && echo "0" > $status
	
	echo "0" > $status
	cd from
fi

if [ `cat $status` == "0" ]; then
	echo "installing required packages for gqrx"
	# do not auto -y, because often this will BREAK YOUR SYSTEM
	# check the packages before continuing please!
	sudo apt-get install \
		libboost-all-dev liblog5cpp-dev \
		gnuradio gnuradio-dev gr-fcdproplus gr-osmosdr libgnuradio-* && echo "1" > $status
fi


if [ `cat $status` == "1" ]; then
	echo "building gqrx"
	cd ~/.builds/gqrx
	mkdir -p build
	cd build
	
	qmake ..
	make && echo "2" > $status
	
	# If the above line gives you an error along the lines of
	# /usr/include/boost/atomic/atomic.hpp:202:16: error: ‘uintptr_t’ was not declared in this scope
	# then add `#include <stdint.h>' just above of the first #include in atomic.hpp
	
	cd $from
	echo "2" > $status
fi

if [ `cat $status` == "2" ]; then
	cd ~/.builds/gqrx/build/
	
	echo "installing gqrx"
	sudo cp gqrx /usr/bin/gqrx
	
	sudo sh -c 'echo "[Desktop Entry]
Version=1.0
Type=Application
Name=Gqrx
Exec=gqrx
Categories=Audio;Education;HamRadio;
MimeType=application/gqrx;
Icon=gqrx" > /usr/share/applications/gqrx.desktop'
	
	sudo cp icons/scope.png /usr/share/pixmaps/gqrx.svg
	
	cd $from
	echo "3" > $status
fi

if [ `cat $status` == "3" ]; then
	echo "done"
fi
