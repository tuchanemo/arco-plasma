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
okular
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
materia-gkt-theme
arcolinux-sddm-materia-git
bibata-cursor-theme-bin
ttf-material-design-iconic-font
## --- dracut package ---
elfutils
pigz
sbsigntools
multipath-tools
dracut
### --- KeePassXC ---
keepassxc
xclip
wl-clipboard
x11-ssh-askpass
### --- archivers ---
unarchiver
lrzip
lzop
p7zip
### --- Messengers ---
telegram-desktop
viber
### --- pkgfile ---
pkgfile
)

count=0
for name in "${list[@]}" ; do
	count=$[count+1]
	tput setaf 3;echo "Installing package nr.  "$count " " $name;tput sgr0;
	func_install $name
done
echo "Fixing hardcoded icon paths for applications - Wait for it and other"
sudo hardcode-fixer
sudo pkgfile -f
sudo systemctl enable pkgfile-update.timer

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
