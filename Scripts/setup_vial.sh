#!/bin/bash

set -e

# create destination directory
cd ~
mkdir Vial
cd Vial

# clone code
git clone https://github.com/vial-kb/vial-gui.git
cd vial-gui


# install required python version
sudo pacman -S --needed pyenv
pyenv install --skip-existing 3.6.15

# create and prepare venv
~/.pyenv/versions/3.6.15/bin/python -m venv venv
venv/bin/pip install --upgrade pip
venv/bin/pip install -r requirements.txt

# write udev rule
export USER_GID=`id -g`; sudo --preserve-env=USER_GID sh -c 'echo "KERNEL==\"hidraw*\", SUBSYSTEM==\"hidraw\", ATTRS{serial}==\"*vial:f64c2b3c*\", MODE=\"0660\", GROUP=\"$USER_GID\", TAG+=\"uaccess\", TAG+=\"udev-acl\"" > /etc/udev/rules.d/59-vial.rules && udevadm control --reload && udevadm trigger'

# create executable
cd ..
cat << 'EOF' > RUN.sh
#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")/vial-gui" && QT_QPA_PLATFORM=xcb venv/bin/fbs run
EOF
chmod +x RUN.sh
