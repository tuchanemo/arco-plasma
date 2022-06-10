#!/bin/bash
#set -e
###############################################################################
# Author	:	Erik Dubois
# Website	:	https://www.erikdubois.be
# Website	:	https://www.arcolinux.info
# Website	:	https://www.arcolinux.com
# Website	:	https://www.arcolinuxd.com
# Website	:	https://www.arcolinuxb.com
# Website	:	https://www.arcolinuxiso.com
# Website	:	https://www.arcolinuxforum.com
###############################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
###############################################################################


###############################################################################
#
#   DECLARATION OF FUNCTIONS
#
###############################################################################


func_install() {
	if pacman -Qi $1 &> /dev/null; then
		tput setaf 2
  		echo "###############################################################################"
  		echo "################## The package "$1" is already installed"
      	echo "###############################################################################"
      	echo
		tput sgr0
	else
    	tput setaf 3
    	echo "###############################################################################"
    	echo "##################  Installing package "  $1
    	echo "###############################################################################"
    	echo
    	tput sgr0
    	sudo pacman -S --noconfirm --needed $1
    fi
}

###############################################################################
echo "Installation of the core software"
###############################################################################

list=(
sddm
arcolinux-wallpapers-git
plasma-meta
## dolphin # in the package kde-system-meta
konsole
## spectacle	# KDE screenshot capture utility
yakuake
kinit
## ------------------
kde-system-meta
dolphin-plugins
plasma-wayland-session
egl-wayland
featherpad
feathernotes
most # need for man
breeze-grub
breeze-gtk
plasma-integration
)

count=0

for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done

###############################################################################

tput setaf 6;echo "################################################################"
echo "Copying all files and folders from /etc/skel to ~"
echo "################################################################"
echo;tput sgr0
cp -Rf ~/.config ~/.config-backup-$(date +%Y.%m.%d-%H.%M.%S)
cp -arf /etc/skel/. ~

tput setaf 5;echo "################################################################"
echo "Enabling sddm as display manager"
echo "################################################################"
echo;tput sgr0
sudo systemctl enable sddm.service -f

tput setaf 2;echo "################################################################"
echo "Removing packages we do not want"
echo "################################################################"
echo;tput sgr0
sudo pacman -Rdd alsa-{utils,ucm-conf,topology-conf}  --noconfirm
sudo pacman -Rdd pulseaudio pipewire-media-session jack2 --noconfirm
sudo pacman -S wireplumber --noconfirm
sudo pacman -S pipewire-{alsa,jack,pulse,zeroconf} --noconfirm
sudo pacman -S gst-plugin-pipewire pulseaudio-qt realtime-privileges --noconfirm
systemctl --user enable pipewire pipewire-pulse wireplumber

tput setaf 7;echo "################################################################"
echo "You now have a very minimal functional desktop"
echo "################################################################"
echo;tput sgr0

tput setaf 11;
echo "################################################################"
echo "Reboot your system"
echo "################################################################"
echo;tput sgr0
