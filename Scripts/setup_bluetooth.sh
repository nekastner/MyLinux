#!/bin/bash

sudo pacman -S bluez bluez-utils bluedevil
sudo systemctl enable --now bluetooth

