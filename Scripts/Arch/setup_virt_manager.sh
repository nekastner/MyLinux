sudo pacman -S --needed qemu-desktop virt-manager dnsmasq iptables-nft
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER
