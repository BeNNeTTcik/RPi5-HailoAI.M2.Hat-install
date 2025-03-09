#!/bin/bash

#read variables
if [ -f version.txt ]; then
    hailort=$(awk -F'=' '/^hailort=/{print $2}' version.txt)
    echo "tappas: $hailort"
else
    echo "Sth wrong"
fi

#try to download the firmware
function catch {
    echo "Failed to download from the primary URL. Trying the first alternative URL..."
    wget http://archive.raspberrypi.com/debian/pool/main/h/hailort/hailort_${hailort}_$(dpkg --print-architecture).deb || {
        echo "Failed to download from the first alternative URL. Trying the second alternative URL..."
        wget http://archive.raspberrypi.com/debian/pool/main/h/hailort/hailort_${hailort}-1_$(dpkg --print-architecture).deb || {
            echo "Failed to download from the second alternative URL. Exiting."
            exit 1
        }
    }
}

# Function to execute commands and catch errors
function try {
    "$@" || catch
}

#main
cd "$HOME/Downloads/RPi5-HailoAI.M2.Hat-install-main"
try wget http://archive.raspberrypi.com/debian/pool/main/h/hailort/hailort_${hailort}_$(dpkg --print-architecture).deb
sudo apt install ./hailort_${hailort}_$(dpkg --print-architecture).deb

#check if hailort is installed
if(hailortcli fw-control identify); then
    hailortcli fw-control identify
else
    echo "Hailo device is not detected, something went wrong"
fi
