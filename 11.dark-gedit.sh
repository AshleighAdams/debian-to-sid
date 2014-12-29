#!/bin/bash

FILENAME="org.gnome.gedit.desktop"
DIR="/usr/share/applications"
FULLPATH="$DIR/$FILENAME"

cat $FULLPATH | sed "s|Exec=gedit|Exec=env GTK_THEME=Adwaita:dark gedit|g" > /tmp/$FILENAME
sudo mv /tmp/$FILENAME $FULLPATH

cp $FULLPATH ~/.local/share/applications/org.gnome.gedit.desktop
