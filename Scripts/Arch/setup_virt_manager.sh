sudo pacman -S qemu-full virt-manager virt-viewer dnsmasq vde2 bridge-utils openbsd-netcat iptables-nft libguestfs
sudo systemctl enable --now libvirtd
sudo usermod -aG libvirt $USER
