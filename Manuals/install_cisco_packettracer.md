# 1. Download Cisco PacketTracer
URL: https://www.netacad.com/resources/lab-downloads

# 2. Build
## 2.1.
```
cd <download destination>
makepkg -si
```

# 3. Create executable Application
```
cd /usr/lib/packettracer
sudo ./packettracer.AppImage --appimage-extract
squashfs-root/AppRun &
```

# 4. Create Desktop Entry
## 4.1. Copy Icon
```
sudo cp /usr/lib/packettracer/squashfs-root/app.png /usr/share/icons/hicolor/48x48/apps/cisco-packettracer.png
```
## 4.2. Write into /usr/share/applications/cisco-packettracer.desktop
```
Name=Cisco PacketTracer
Exec=/usr/lib/packettracer/squashfs-root/AppRun
Icon=cisco-packettracer
Type=Application
Categories=Education;
Keywords=cisco;packettracer;
```
