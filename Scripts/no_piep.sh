#!/bin/bash

sudo modprobe -r pcspkr
echo "blacklist pcspkr" | sudo tee /etc/modprobe.d/nobeep.conf

