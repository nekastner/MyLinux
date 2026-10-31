# 1. Prepair medium
fdisk /dev/<medium>
  g n t w

# 2. Setup LUKS
sudo cryptsetup luksFormat /dev/<medium>
sudo cryptsetup open /dev/<medium> <name>
sudo mkfs.btrfs -L <label> /dev/mapper/<name>
