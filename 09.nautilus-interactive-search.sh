#!/bin/bash

sudo apt-get build-dep nautilus

sudo rm -rf /tmp/naut # make sure it's gone!


mkdir /tmp/naut
cp  09.interactive_search.patch /tmp/naut/interactive_search.patch

cd /tmp/naut/
apt-get source nautilus

echo "preparing patch..."

mv `echo */` nautilus-current/


echo "applying patch..."
patch -p0 < ./interactive_search.patch

echo "building..."
cd nautilus-current/
./configure prefix=/usr/
make
sudo make install

echo "Enabling interactive search"
gsettings set org.gnome.nautilus.preferences enable-interactive-search true

