#!/bin/bash

#read variables
if [ -f version.txt ]; then
    hailort=$(awk -F'=' '/^hailort=/{print $2}' version.txt)
    echo "HailoRT: $hailort"
else
    echo "Sth wrong"
fi

#try to download the firmware
function catch {
    echo "Failed to download from the primary URL. Trying the first alternative URL..."
    if wget -q "http://archive.raspberrypi.com/debian/pool/main/h/hailort/hailort_${hailort//\"/}-1_$(dpkg --print-architecture).deb"; then
    	install_file="hailort_${hailort//\"/}-1_$(dpkg --print-architecture).deb"
    else
        echo "Failed to download from the first alternative URL. Trying the second alternative URL..."
        if wget -q "http://archive.raspberrypi.com/debian/pool/main/h/hailort/hailort_${hailort//\"/}-2_$(dpkg --print-architecture).deb"; then
        install_file="hailort_${hailort//\"/}-2_$(dpkg --print-architecture).deb"
            echo "Failed to download from the second alternative URL. Exiting."
            exit 1
        fi
    fi
}

# Function to execute commands and catch errors
function try {
    "$@" || catch
}

#main
cd "$HOME/RPi5-HailoAI.M2.Hat-install-main"

if wget -q "http://archive.raspberrypi.com/debian/pool/main/h/hailort/hailort_${hailort//\"/}_$(dpkg --print-architecture).deb"; then
   install_file="hailort_${hailort//\"/}_$(dpkg --print-architecture).deb"
else
   catch
fi
sudo apt install ./${install_file//\"/}

check if hailort is installed
if(hailortcli fw-control identify); then
    echo "Ready!!"
else
    echo "Hailo device is not detected, something went wrong"
fi
