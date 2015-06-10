#!/bin/bash

# https://bbs.archlinux.org/viewtopic.php?pid=1518698#p1518698

#echo "
#.header-bar.default-decoration {
#	border: none;
#	background-image: linear-gradient(to bottom,
#		shade(@theme_bg_color, 1.042),
#		shade(@theme_bg_color, 0.999));
#	box-shadow: none; /*inset 0 1px shade(@theme_bg_color, 1.4);*/
#	border-top: 1px solid shade(@theme_bg_color, 1.072);
#}
#
#.ssd .titlebar:backdrop {
#    background-image: linear-gradient(to bottom, @theme_bg_color);
#}
#
#/*
#.header-bar.default-decoration .button.titlebutton {
#	padding-top: 2px;
#	padding-bottom: 2px;
#}
#*/
#"

# https://bbs.archlinux.org/viewtopic.php?pid=1519321#p1519321

echo "

.ssd .titlebar {
    border: none;
    background-image: linear-gradient(to bottom,
                                      shade(@theme_bg_color, 1.042),
                                      shade(@theme_bg_color, 0.999));
    box-shadow: none;
    border-top: 1px solid shade(@theme_bg_color, 1.072);
}

.ssd .titlebar:backdrop {
    background-image: linear-gradient(to bottom, @theme_bg_color);
}

.ssd .titlebar .button.titlebutton {
    /*padding: 3px;*/
}

.menubar {
    background-image: linear-gradient(to bottom,
                                      shade(@theme_bg_color, 0.999),
                                      shade(@theme_bg_color, 0.985));
    border-bottom: 1px solid shade(@theme_bg_color, 0.679);
}

.menubar:backdrop {
    background-image: linear-gradient(to bottom, @theme_bg_color);
}

" > ~/.config/gtk-3.0/gtk.css
