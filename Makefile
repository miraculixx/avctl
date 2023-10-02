install:
	sudo ln -fs $(realpath ./avctl.sh) /usr/local/bin/avctl
	sudo ln -fs $(realpath ./easyoptions) /usr/local/bin/easyoptions
	sudo ln -fs $(realpath ./avctl-off.desktop) $(HOME)/.local/share/applications/avctl-off.desktop
	sudo ln -fs $(realpath ./avctl-on.desktop) $(HOME)/.local/share/applications/avctl-on.desktop