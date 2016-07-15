#!/bin/bash
# Make config directories
mkdir /usr/lib/systemd/system
mkdir /etc/X11/xorg.conf.d
mkdir /etc/lightdm/lightdm.conf.d
# Add Specific sources.list
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cp -v sources.list /etc/apt/
cp -v 10-mx-xfce412 /etc/apt/preferences.d/
# Add Specific global bashrc
mv /etc/bash.bashrc /etc/bash.bashrc.bak
cp -v bash.bashrc /etc/
# Add Lightdm config
mv /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.bak
cp -v lightdm-gtk-greeter.conf /etc/lightdm/
cp -v 01_abhis3k.conf /etc/lightdm/lightdm.conf.d/
# Add Super bashrc and zshrc
cp -v ../bashrc ~/.bashrc
cp -v ../zshrc ~/.zshrc
cp -v ../bashrc /etc/skel/.bashrc
cp -v ../zshrc /etc/skel/.zshrc
# Enable new bashrc
. /etc/bash.bashrc
. ~/.bashrc
# extract apt-file and apt archive cache
tar xvfz apt-cache-04052015.tar.gz -C /var/cache/apt/
# Enable multilib
dpkg --add-architecture i386
# Configure locales
dpkg-reconfigure locales
# MX15 repo for XFCE 4.12
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14E225A0 
# Add infinality ppa
echo "deb http://ppa.launchpad.net/no1wantdthisname/ppa/ubuntu vivid main" > /etc/apt/sources.list.d/infinality.list
echo "#deb-src http://ppa.launchpad.net/no1wantdthisname/ppa/ubuntu vivid main" >> /etc/apt/sources.list.d/infinality.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E985B27B
# Add deb-multimedia keyring
apt-get update && apt-get install --allow-unauthenticated -y deb-multimedia-keyring
# upgrade
apt-get update && apt-get dist-upgrade -y
# install desktop
apt-get install task-xfce-desktop -y
# install firmware and essentials
apt install firmware-linux-nonfree firmware-misc-nonfree firmware-realtek firmware-iwlwifi firmware-atheros intel-microcode -y
apt install mplayer smplayer vlc audacity handbrake-gtk gparted qmmp qbittorrent browser-plugin-vlc browser-plugin-freshplayer-pepperflash icedtea-plugin qt4-qtconfig command-not-found libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-math python-vte fontconfig-infinality vim-gtk geany -y
# Configure fonts
bash /etc/fonts/infinality/infctl.sh setstyle
# install essential system tools
apt install ssh cowsay fortunes pv zsh aria2 conky-all -y
# install games
apt install aisleriot gnome-chess gnome-sudoku gnome-mahjongg gnome-mines supertux supertuxkart -y
# install various tools
apt install exfat-utils exfat-fuse hfsplus hfsutils hfsprogs testdisk adb fastboot gddrescue hddtemp hdparm smartmontools dconf-editor dconf-cli -y
apt install fonts-indic fonts-inconsolata fonts-ubuntu-title aptitude apt-listbugs wireshark -y
# install android development tools & kernel build options
#apt-get install openjdk-8-jdk bison g++ gcc clang llvm git subversion gperf libxml2-utils subversion build-essential kernel-package kernel-wedge libncurses5-dev ccache libgtk2.0-dev libglib2.0-dev libglade2-dev linux-headers-amd64 android-sdk-build-tools -y
# Install xfce required extras
apt-get install gvfs-backends gvfs-fuse clearlooks-phenix-theme gtk2-engines-murrine gtk2-engines-pixbuf gtk3-engines-xfce mesa-utils mesa-utils-extra light-locker -y
apt-get install libtxc-dxtn0 libtxc-dxtn0:i386 steam gksu sudo hexchat vainfo sysinfo xfce4-whiskermenu-plugin xdg-user-dirs xdg-user-dirs-gtk faenza-icon-theme human-icon-theme lxde-icon-theme numlockx pulseaudio pavucontrol xarchiver gimp gimp-data-extras sound-theme-freedesktop -y
apt-get install xfce4-pulseaudio-plugin xfce-theme-manager -y
# Install deb packages
dpkg -i *.deb
# Fix Problems
apt-get -fy install
# Fix all updates
apt-get update && apt-get dist-upgrade -y && update-command-not-found
# extra fun
tar xvfz ../redhat-icons.tar.gz -C /usr/share/icons
update-alternatives --display x-cursor-theme 
update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /usr/share/icons/Bluecurve-FC4/cursor.theme 8000
update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /usr/share/icons/Bluecurve-FC6/cursor.theme 6000
update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /usr/share/icons/Bluecurve-inverse-FC4/cursor.theme 4000
update-alternatives --install /usr/share/icons/default/index.theme x-cursor-theme /usr/share/icons/Bluecurve-inverse-FC6/cursor.theme 2000
update-alternatives --display x-cursor-theme 
tar xvfz ../osx-icons.tar.gz -C /usr/share/icons
tar xvfz ../elementary-xfce.tar.gz -C /usr/share/icons
tar xvfz ../vibrancy-icons.tar.gz -C /usr/share/icons
tar xvfz ../restricted-fonts.tar.gz -C /usr/share/fonts/truetype
for dir in /usr/share/icons/*
do
  test -d "$dir" || continue
  update-icon-caches "$dir"
done
for dir in /usr/share/fonts/truetype/*
do
  test -d "$dir" || continue
  cd "$dir"
  mkfontscale .
  mkfontdir .
done
fc-cache -fv

# Install Web Developer Horde
apt-get install php5-curl php5-gd php5-imagick php5-imap php5-mcrypt php5-memcache php5-cli php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-fpm php5-mysqlnd php5-pgsql php5-xcache mysql-server mysql-client postgresql-client postgresql lighttpd -y
# Install extra Designer Mode
apt-get install darktable rawtherapee audacious gjay clamtk pinta -y
# Set system-wide fonts (Gnome)
gsettings set org.gnome.desktop.interface document-font-name 'Verdana 10'
gsettings set org.gnome.desktop.interface font-name 'Lucida Grande 10'
gsettings set org.gnome.desktop.interface monospace-font-name 'Inconsolata Medium 12'
dconf write /org/gnome/desktop/interface/font-name "'Lucida Grande 10'"
dconf write /org/gnome/desktop/interface/document-font-name "'Verdana 10'"
dconf write /org/gnome/desktop/interface/monospace-font-name "'Inconsolata Medium 12'"
# Check system-wide fonts (Gnome)
gsettings get org.gnome.desktop.interface document-font-name 
gsettings get org.gnome.desktop.interface font-name 
gsettings get org.gnome.desktop.interface monospace-font-name 
dconf read /org/gnome/desktop/interface/font-name 
dconf read /org/gnome/desktop/interface/document-font-name 
dconf read /org/gnome/desktop/interface/monospace-font-name 
