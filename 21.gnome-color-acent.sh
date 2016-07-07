#!/bin/bash

set -e

#sudo apt install ruby-full
#sudo gem install sass

tmp="$(pwd)/.tmp.21"

[[ ! -d "$tmp" ]] && mkdir "$tmp"

pushd "$tmp"

if [[ ! -d "gtk+" ]]; then
	git clone git://git.gnome.org/gtk+
fi

pushd "gtk+"
	git checkout master
	git pull
	git checkout $(pkg-config --modversion gtk+-3.0)
popd

[[ -d "AdwaitaAccent" ]] && rm -rf "AdwaitaAccent"
mkdir "AdwaitaAccent"

cp -r /usr/share/themes/Adwaita/* AdwaitaAccent

# this doesn't need to be ran, actually, it breaks it
#sed -i "s/Adwaita/AdwaitaAccent/g" AdwaitaAccent/index.theme
cp -r "gtk+/gtk/theme/Adwaita/"*  AdwaitaAccent/gtk-3.0

pushd AdwaitaAccent/gtk-3.0
	echo updating color
	sed -i "s/4a90d9/bb22ff/g" _colors.scss
	echo recompiling
	sass --update --sourcemap=none .
	echo "fixing resource"
	sed -i "s|resource:///org/gtk/libgtk/theme/Adwaita/||g" gtk.css gtk-dark.css
popd

echo installing files

THEME_LOCATION=~/.themes # ~/.local/share/themes in later gtk versions, but 2 needs it here

[[ ! -d $THEME_LOCATION ]] && mkdir $THEME_LOCATION
[[ -d "$THEME_LOCATION/AdwaitaAccent" ]] && rm -rf "$THEME_LOCATION/AdwaitaAccent"
mv AdwaitaAccent "$THEME_LOCATION/"

popd # tmp
