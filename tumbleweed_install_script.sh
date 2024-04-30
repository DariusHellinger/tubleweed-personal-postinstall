#!/bin/bash

##############
#system basics
##############

sudo zypper install --no-confirm flatpak curl distrobox

#add flathub repo
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

#installing brave
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo zypper addrepo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo zypper install --no-confirm brave-browser

#installing other core
sudo zypper install --no-confirm inkscape krename meld thunderbird skanpage krdc syncthing spotify-easyrpm
sudo zypper install --allow-unsigned-rpm ./rustdesk-1.2.3-2.x86_64-suse.rpm

sudo flatpak install -y --noninteractive org.onlyoffice.desktopeditors com.jgraph.drawio.desktop md.obsidian.Obsidian

#install full vlc via Pacman repo
sudo zypper ar -cfp 90 -n Packman http://ftp.gwdg.de/pub/linux/misc/packman/suse/openSUSE_Tumbleweed/ packman
sudo zypper ref
sudo zypper in vlc vlc-codecs
sudo zypper dup --from packman --allow-vendor-change

#better bash
returnDirectory=$PWD
cd ~
cp .bashrc .bashrc.bckp
cd returnDirectory
sudo zypper install --no-confirm git fonts-powerline
git clone --recursive https://github.com/andresgongora/synth-shell.git
chmod +x synth-shell/setup.sh
cd synth-shell
./setup.sh

cd $returnDirectory

##################
#move config files
##################

#synth-shell
cp ./synth-shell-greeter.config ~/.config/synth-shell/synth-shell-greeter.config
cp ./synth-shell-prompt.config ~/.config/synth-shell/synth-shell-prompt.config
cp ./synth-shell-prompt-root.config ~/.config/synth-shell/synth-shell-prompt-root.config

#KDE colors
cp ./BreezeDarkTinted.colors /home/testy/.local/share/color-schemes/BreezeDarkTinted.colors
plasma-apply-colorschemes BreezeDarkTinted
#KDE shortcuts
cp ./kglobalshortcutsrc ~/.config/kglobalshortcutsrc

#launching spotfy installer
spotify-easyrpm --quiet

#setup distrobox with ubuntu and enable docker

sudo systemctl start docker
sudo systemctl enable docker
distrobox-create --root -l quay.io/toolbx/ubuntu-toolbox:latest -n Ubuntu
