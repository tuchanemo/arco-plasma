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

func_category() {
	tput setaf 5;
	echo "################################################################"
	echo "Installing software for category " $1
	echo "################################################################"
	echo;tput sgr0
}

###############################################################################

func_category Additional-distro-specific

list=(
ark
ffmpegthumbs
gwenview
imagemagick
ocs-url
packagekit-qt5
systemd-kcm
w3m
hardcode-fixer-git
## --------------
galculator
kgpg
xsettingsd
fish
fzf
arcolinux-fish-git
xdg-desktop-portal
## --- Materia theme ---
kvantum
kvantum-theme-materia
materia-kde
gtk-engines
gtk-engine-murrine
materia-gtk-theme
arcolinux-sddm-materia-git
bibata-cursor-theme-bin
ttf-material-design-iconic-font
papirus-icon-theme
## --- dracut package ---
elfutils
pigz
sbsigntools
multipath-tools
dracut
### --- KeePassXC ---
xclip
wl-clipboard
x11-ssh-askpass
keepassxc
### --- archivers ---
unarchiver
lrzip
lzop
p7zip
### --- Messengers ---
webkit2gtk
avisynthplus
ladspa
qt6-languageserver
telegram-desktop
viber
### --- pkgfile ---
pkgfile
### --- firewall ---
ufw
### --- video driver ---
xf86-video-ati
xf86-video-radeon
vulkan-mesa-layers
vulkan-radeon
### --- Firefox ---
firefox-i18n-ru
firefox-decentraleyes
firefox-ublock-origin
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done
echo "Fixing hardcoded icon paths for applications - Wait for it and other"
sudo hardcode-fixer
sudo pkgfile --update
sudo systemctl enable pkgfile-update.timer
sudo systemctl enable ufw --now
sudo ufw enable

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
