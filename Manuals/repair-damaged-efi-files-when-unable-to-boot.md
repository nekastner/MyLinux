# 1. mount the relevant partitions of the system
```
mount -t proc proc /new_root/proc
mount -t sysfs sys /new_root/sys
mount -o bind /dev /new_root/dev
```

# 2. chroot into the system
```
chroot /new_root /bin/bash
```

# 3. mount the boot partition
```
modprobe fat; modprobe vfat
modprobe nls_cp437
modprobe nls_iso8859-1

mount -t vfat /dev/<boot partition> /boot
```

# 4. set correct partuuid
```
sed -i "s/PARTUUID=[^:]*/PARTUUID=$(blkid -s PARTUUID -o value /dev/<boot partition>)/" /etc/kernel/cmdline
```

# 5. re-build efi-files
```
mkinitcpio -P
ls -l /boot/EFI/Linux/
```

# 6. unmount partitions and reboot
```
umount /boo
exit

umount /new_root/dev /new_root/sys /new_root/proc
reboot -f
```
