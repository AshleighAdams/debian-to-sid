# enable flat-audio in pulse

[[ ! -f ~/.config/pulse/daemon.conf ]] && cp /etc/pulse/daemon.conf ~/.config/pulse/daemon.conf

sed "s/; flat-volumes = yes/flat-volumes = no/g" --in-place ~/.config/pulse/daemon.conf
