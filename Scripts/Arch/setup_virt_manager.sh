sudo pacman -S --needed qemu-desktop virt-manager dnsmasq iptables-nft swtpm
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER
