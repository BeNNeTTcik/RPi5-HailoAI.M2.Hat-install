#!/bin/bash
#read variables
if [ -f version.txt ]; then
    hailort=$(awk -F'=' '/^hailort=/{print $2}' version.txt)
    echo "Firmware: $hailort"
else
    echo "Sth wrong"
fi

FLAG_FILE="/tmp/script_after_reboot.flag"

#before reboot
function before_reboot {
    #system update & upgrade
    echo "System Update & Upgrade"
    sudo apt update -y
    sudo apt upgrade -y

    #kernel headers installation
    echo "Installing kernel headers"
    sudo apt install linux-headers-$(uname -r) -y
    sudo apt install build-essential -y

    #clone the firmware repository
    echo "Cloning the firmware repository with version ${hailort}"
    git clone https://github.com/hailo-ai/hailort-drivers.git --branch v${hailort//\"/}
    cd hailort-drivers/

    #install the firmware
    echo "Installing the firmware"
    cd linux/pcie
    make all
    sudo make install
    cd ../..
    ./download_firmware.sh
    sudo mkdir -p /lib/firmware/hailo
    sudo mv hailo8_fw.${hailort//\"/}.bin /lib/firmware/hailo/hailo8_fw.bin
    sudo cp ./linux/pcie/51-hailo-udev.rules /etc/udev/rules.d/
    cd "$HOME/RPi5-HailoAI.M2.Hat-install-main"
    sudo reboot
    
    

