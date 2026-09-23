#!/bin/bash

if (( $# != 1 ));
then
	echo "ERROR ==> Wrong usage!"
	echo ""Parameters: <path to new packettracer.deb>
	exit 1
fi

PACKETTRACER_DEB="$1"

cp "$PACKETTRACER_DEB" "$HOME/.cache/paru/clone/packettracer/"
paru -S packettracer
