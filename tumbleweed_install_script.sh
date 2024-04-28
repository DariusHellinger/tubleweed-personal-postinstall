#!/bin/bash

#system basics

sudo zypper install --no-confirm flatpak curl distrobox

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

#launching spotfy installer
spotify-easyrpm --quiet
