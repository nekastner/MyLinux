sudo pacman -S cpupower
cpupower frequency-info
sudo systemctl enable –-now cpupower.service
sudo nano /etc/default/cpupower-service.conf
sudo systemctl restart cpupower.service
cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_max_freq
