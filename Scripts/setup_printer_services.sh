#!/bin/bash

# install and enable avahi so cups and sane can find the printers
sudo pacman -S avahi
sudo systemctl enable --now avahi-daemon

# install and start printing services
sudo pacman -S cups ghostscript gsfonts
sudo systemctl enable --now cups

# add use to line-printer-group
sudo usermod -aG lp,sys user

# install hp libs
sudo pacman -S hplip

# setup printer
hp-setup -i

# install scanning services
sudo pacman -S sane sane-airscan xsane

# list scanners in command line
scanimage -L

# install gui vor sane
sudo pacman -S simple-scan

