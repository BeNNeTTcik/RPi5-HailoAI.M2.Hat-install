#!/bin/bash
#define version
source ./config.sh

#system update & upgrade
sudo apt update -y
sudo apt upgrade -y

#kernel headers installation
sudo apt install linux-headers-$(uname -r) -y
sudo apt install build-essential -y

#clone the firmware repository
git clone https://github.com/hailo-ai/hailort-drivers.git --branch $version
cd hailort-drivers/

#install the firmware
cd linux/pcie
make all
sudo make install
cd ../..
./download_firmware.sh
sudo mkdir -p /lib/firmware/hailo
sudo mv hailo8_fw.$version.bin /lib/firmware/hailo/hailo8_fw.bin
sudo cp ./linux/pcie/51-hailo-udev.rules /etc/udev/rules.d/

#reboot the system
sudo reboot