#!/bin/bash
# Add Specific sources.list
mv /etc/apt/sources.list /etc/apt/sources.list.bak
cp -v sources.list /etc/apt/
# Add Specific global bashrc
mv /etc/bash.bashrc /etc/bash.bashrc.bak
cp -v bash.bashrc /etc/
# Add Super bashrc and zshrc
cp -v ../bashrc ~/.bashrc
cp -v ../zshrc ~/.zshrc
cp -v ../bashrc /etc/skel/.bashrc
cp -v ../zshrc /etc/skel/.zshrc
# Enable new bashrc
. /etc/bash.bashrc
. ~/.bashrc
# Enable multilib
dpkg --add-architecture i386
# Configure locales
dpkg-reconfigure locales
# Various repos signing
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 0F164EEB CE49F8C5 F0B0A992 E985B27B 65558117 719A73CF 
# Add deb-multimedia keyring
apt-get update && apt-get install --allow-unauthenticated -y deb-multimedia-keyring
apt-get update
apt-get install apt-transport-https apt-transport-tor -y
# upgrade
apt-get update && apt-get dist-upgrade -y
# install desktop
apt install task-xfce-desktop gtk3-engines-xfce firefox-esr evolution-ews dconf-cli dconf-editor -y
# install firmware and essentials
apt install firmware-linux-nonfree firmware-misc-nonfree firmware-realtek firmware-iwlwifi firmware-atheros intel-microcode -y
apt install mplayer smplayer vlc audacity handbrake-gtk qmmp qbittorrent qt4-qtconfig command-not-found -y
apt install browser-plugin-vlc browser-plugin-freshplayer-pepperflash icedtea-plugin browser-plugin-freshplayer-libpdf -y
apt install libreoffice-writer libreoffice-calc libreoffice-impress libreoffice-math -y
# install various tools
apt install exfat-utils exfat-fuse hfsplus hfsutils hfsprogs testdisk adb fastboot gddrescue hddtemp hdparm smartmontools gparted -y
apt install fontconfig-infinality font-manager \
            fonts-droid-fallback fonts-noto fonts-roboto fonts-indic fonts-inconsolata fonts-ubuntu-title -y
# Configure fonts
bash /etc/fonts/infinality/infctl.sh setstyle
# install essential system tools
apt install ssh cowsay fortunes pv zsh aria2 conky-all python-vte vim-gtk geany aptitude apt-listbugs gksu sudo numlockx wireshark -y
# install nvidia stuffs
apt install nvidia-settings nvidia-opencl-icd nvidia-detect nvidia-alternative nvidia-libopencl1 nvidia-driver -y
nano /etc/X11/xorg.conf.d/20-nvidia.conf
nano /etc/X11/xorg.conf.d/30-screen.conf
nano /etc/X11/xorg.conf.d/50-synaptics.conf
# install games
apt install aisleriot gnome-chess gnome-sudoku gnome-mahjongg gnome-mines supertux supertuxkart -y
# install android development tools & kernel build options
#apt-get install openjdk-8-jdk bison g++ gcc clang llvm git subversion gperf libxml2-utils subversion build-essential kernel-package kernel-wedge libncurses5-dev ccache libgtk2.0-dev libglib2.0-dev libglade2-dev linux-headers-amd64 android-sdk-build-tools -y
# Install xfce required extras
apt install gksu sudo gvfs-backends gvfs-fuse gtk2-engines-murrine gtk2-engines-pixbuf  -y
apt install libtxc-dxtn0 libtxc-dxtn0:i386 steam hexchat vainfo xdg-user-dirs-gtk lightdm-gtk-greeter-settings -y
apt install numix-icon-theme-circle lxde-icon-theme faba-icon-theme faenza-icon-theme \
            human-icon-theme lxde-icon-theme sound-theme-freedesktop -y
# Install extra Designer Mode
apt-get install darktable rawtherapee audacious gjay clamtk pinta -y
# Install deb packages
dpkg -i *.deb
# Fix Problems
apt -fy install
# Fix all updates
apt update && apt full-upgrade -y && update-command-not-found
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

# Make config directories
mkdir /usr/lib/systemd/system
mkdir /etc/X11/xorg.conf.d
mkdir /etc/lightdm/lightdm.conf.d
# Add Lightdm config
mv /etc/lightdm/lightdm-gtk-greeter.conf /etc/lightdm/lightdm-gtk-greeter.conf.bak
cp -v lightdm-gtk-greeter.conf /etc/lightdm/
cp -v 01_abhis3k.conf /etc/lightdm/lightdm.conf.d/


# Install Web Developer Horde
apt-get install php5-curl php5-gd php5-imagick php5-imap php5-mcrypt php5-memcache php5-cli php5-recode php5-snmp php5-sqlite php5-tidy php5-xmlrpc php5-xsl php5-fpm php5-mysqlnd php5-pgsql php5-xcache mysql-server mysql-client postgresql-client postgresql lighttpd -y
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
