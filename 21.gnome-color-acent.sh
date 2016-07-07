#!/bin/bash

set -e

sudo apt install ruby-full
sudo gem install sass
gsettings set org.gnome.desktop.interface gtk-color-scheme "selected_bg_color:#bb22ff;"

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
	
	# add support for specific apps to take on the Adwaita theme
	echo '@import url("resource:///org/gnome/builder/theme/Adwaita-shared.css");' >> gtk.css
	echo '@import url("resource:///org/gnome/builder/theme/Adwaita-shared.css");' >> gtk-dark.css
	
	echo '@import url("resource:///org/gnome/gedit/css/gedit.adwaita.css");' >> gtk.css
	echo '@import url("resource:///org/gnome/gedit/css/gedit.adwaita.css");' >> gtk-dark.css
popd


echo extracting gnome-shell theme

gst=/usr/share/gnome-shell/gnome-shell-theme.gresource
mkdir -p AdwaitaAccent/gnome-shell/
for r in `gresource list $gst`; do
	gresource extract $gst $r > "AdwaitaAccent/gnome-shell/$workdir${r/#\/org\/gnome\/shell\/theme/}"
done

#"215d9c" to "f43030"; "256ab1" to "bd3232"; and "rgba(33, 93, 156," to "rgba(155, 33, 33,")

sed -i "s/215d9c/76219C/g" AdwaitaAccent/gnome-shell/gnome-shell.css
sed -i "s/rgba(33, 93, 156/rgba(118, 33, 156/g" AdwaitaAccent/gnome-shell/gnome-shell.css
sed -i "s/256ab1/8D25B1/g" AdwaitaAccent/gnome-shell/gnome-shell.css
#sed -i 's/#panel {\
#  background-color: black;/#panel {\
#  background-color: transparent;/g' AdwaitaAccent/gnome-shell/gnome-shell.css

echo installing files

THEME_LOCATION=~/.themes # ~/.local/share/themes in later gtk versions, but 2 needs it here

[[ ! -d $THEME_LOCATION ]] && mkdir $THEME_LOCATION
[[ -d "$THEME_LOCATION/AdwaitaAccent" ]] && rm -rf "$THEME_LOCATION/AdwaitaAccent"
mv AdwaitaAccent "$THEME_LOCATION/"

popd # tmp
