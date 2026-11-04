# Arch Linux: Boot-Rettung bei LUKS + btrfs + UKI

Stand: 2026-11-03

## Symptom und Ursachen

Der Boot bricht in der `[rootfs ]#`-Shell ab, meist mit „/dev/mapper/root does not exist“ oder „failed to mount real root device“. Fast immer passt die Kernel-cmdline nicht zur Platte.

Häufige Ursachen:

- Falsche ID in `cryptdevice=`, etwa weil die cmdline von einem anderen PC kopiert wurde.
- `PARTUUID` und `UUID` verwechselt: Präfix und Wert müssen zusammenpassen.
- `rootflags=subvol=@` fehlt, obwohl root auf btrfs in einem Subvolume liegt.
- Laufender Kernel passt nicht zu den Modulen auf der Platte, dann fehlt z. B. vfat.
- `/etc/fstab` enthält ebenfalls fremde UUIDs.

## Mein Setup

| Teil | Wert |
| --- | --- |
| Boot/EFI-Partition | `/dev/sda1` (vfat) |
| Verschlüsselte Partition | `/dev/sda2` (crypto_LUKS) |
| Entsperrtes Gerät | `/dev/mapper/root` (btrfs) |
| Root-Subvolume | `@` |
| Kernel | `linux-zen` |
| Boot-Art | UKI, cmdline in `/etc/kernel/cmdline` |
| Preset | `/etc/mkinitcpio.d/linux-zen.preset` |

Korrekte cmdline:

```
cryptdevice=PARTUUID=<partuuid-von-sda2>:root root=/dev/mapper/root rootflags=subvol=@ rw
```

Die PARTUUID gehört zu **sda2**, nicht zu `/dev/mapper/root` (das hat keine). Anzeigen mit:

```sh
blkid -s PARTUUID -o value /dev/sda2
```

## Schnell booten aus der rootfs-Shell

So kommst du einmalig ins System, ohne etwas zu ändern. Die rootfs-Shell läuft im RAM; was dort außerhalb von `/new_root` geändert wird, ist nach dem Neustart weg.

```sh
blkid                                   # Partitionen ansehen
cryptsetup open /dev/sda2 root          # entsperren (entfällt, wenn schon offen)
mount -o subvol=@ /dev/mapper/root /new_root
exit                                    # Bootvorgang läuft weiter
```

`/new_root` ist nur der Mountpunkt für die echte Root-Partition. Beim Weiterbooten wird er per `switch_root` zu `/`. Änderungen unter `/new_root/...` landen direkt auf der Platte.

## Dauerhaft reparieren per chroot

Das ist der Weg, der beim letzten Mal funktioniert hat. Voraussetzung: sda2 ist entsperrt und `@` unter `/new_root` gemountet (siehe oben, ohne `exit`).

1. In das System wechseln:

    ```sh
    mount -t proc proc /new_root/proc
    mount -t sysfs sys /new_root/sys
    mount -o bind /dev /new_root/dev
    chroot /new_root /bin/bash
    ```

    Die Meldung „Inappropriate ioctl for device“ ist harmlos.

2. EFI-Partition mounten (Ziel steht im Preset unter `default_uki`):

    ```sh
    grep uki /etc/mkinitcpio.d/linux-zen.preset
    modprobe fat; modprobe vfat; modprobe nls_cp437; modprobe nls_iso8859-1
    mount -t vfat /dev/sda1 /efi            # oder /boot, je nach Preset
    ```

3. cmdline korrigieren und prüfen:

    ```sh
    sed -i "s/PARTUUID=[^:]*/PARTUUID=$(blkid -s PARTUUID -o value /dev/sda2)/" /etc/kernel/cmdline
    cat /etc/kernel/cmdline
    ```

4. `/etc/fstab` mit `blkid` vergleichen: UUIDs und `subvol=`-Optionen müssen stimmen.

5. UKI neu bauen und prüfen, ob die `.efi`-Datei die aktuelle Uhrzeit hat:

    ```sh
    mkinitcpio -P
    ls -l /efi/EFI/Linux/
    ```

6. Aushängen und neu starten:

    ```sh
    umount /efi
    exit
    umount /new_root/dev /new_root/sys /new_root/proc
    reboot -f
    ```

## Plan B: Live-USB

Nötig, wenn vfat sich nicht laden lässt (`uname -r` passt nicht zu `ls /usr/lib/modules/`) oder `cryptsetup` im initramfs fehlt. Der Kernel des Live-USB kann alles Nötige.

```sh
cryptsetup open /dev/sda2 root
mount -o subvol=@ /dev/mapper/root /mnt
mount /dev/sda1 /mnt/efi                 # oder /mnt/boot, je nach Preset
arch-chroot /mnt
```

Im chroot weiter mit Schritt 3 bis 5 von oben. Fehlt `linux-zen` auf der Platte, mit Internet `pacman -S linux-zen` installieren. Danach `exit`, `umount -R /mnt`, `reboot`.

## Typische Fehlermeldungen

| Meldung | Ursache | Lösung |
| --- | --- | --- |
| /dev/mapper/root does not exist | Falsche ID in `cryptdevice=` | Mit `cryptsetup open` entsperren, dann cmdline fixen |
| failed to mount real root device | Subvolume fehlt oder `root=` falsch | `mount -o subvol=@ /dev/mapper/root /new_root` |
| unknown filesystem type crypto_LUKS | Verschlüsselte Partition direkt gemountet | `/dev/mapper/root` mounten, nicht `/dev/sda2` |
| unknown filesystem type vfat | vfat-Modul nicht im initramfs | Im chroot `modprobe vfat`, sonst Live-USB |
| /bin/bash: No such file or directory | btrfs ohne Subvolume gemountet | Neu mounten mit `-o subvol=@` |
| target is busy | proc/sys/dev noch unter `/new_root` | Erst diese aushängen, `cd /` |
| Inappropriate ioctl for device | Bash ohne Job-Kontrolle | Harmlos, weitermachen |
