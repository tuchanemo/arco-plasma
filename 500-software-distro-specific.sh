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
systemd-kcm
w3m
hardcode-fixer-git
## --------------
kcalc
kgpg
xsettingsd
fish
fzf
arcolinux-fish-git
xdg-desktop-portal
xdg-user-dirs
## --- Materia theme ---
#kvantum
#kvantum-theme-materia
#materia-kde
#gtk-engines
#gtk-engine-murrine
#materia-gtk-theme
#arcolinux-sddm-materia-git
#bibata-cursor-theme-bin
#ttf-material-design-iconic-font
#papirus-icon-theme
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
cabextract
### --- Messengers ---
viber
### --- pkgfile ---
pkgfile
### --- firewall ---
ufw
### --- video driver ---
libva-mesa-driver
libva-utils
libvdpau-va-gl
lib32-libva-mesa-driver
lib32-mesa-vdpau
bigsh0t
mediainfo
vulkan-mesa-layers
vulkan-radeon
### --- Firefox ---
zenity
kdialog
firefox
firefox-i18n-ru
gnome-keyring
### --- nano syntax highlighting ---
nano-syntax-highlighting
### --- arcolinux configs ---
arcolinux-config-all-desktops-git
arcolinux-root-git
arcolinux-cron-git
### --- text editor ---
micro
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
xdg-user-dirs-update
systemctl --user enable xdg-user-dirs-update
echo "include /usr/share/nano-syntax-highlighting/*.nanorc" >> ~/.nanorc

###############################################################################

tput setaf 11;
echo "################################################################"
echo "Software has been installed"
echo "################################################################"
echo;tput sgr0
