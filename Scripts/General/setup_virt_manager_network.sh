#!/bin/bash

if (( $# != 1 ));
then
	echo "ERROR ==> Wrong usage!"
	echo "Parameters: <ssid>"
	exit 1
fi

SSID="$1"

#sudo virsh net-define "/etc/libvirt/qemu/networks/${ssid}.xml" # if the required network does not exist
sudo virsh net-start "$ssid"
sudo virsh net-autostart "$ssid"
sudo virsh net-list --all
