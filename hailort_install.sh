#!/bin/bash
#define version
source ./config.sh

#try to download the firmware
function catch {
    echo "Failed to download from the primary URL. Trying the first alternative URL..."
    wget http://alternative-url.com/path/to/hailort_${version}_arm64.deb || {
        echo "Failed to download from the first alternative URL. Trying the second alternative URL..."
        wget http://alternative-url.com/path/to/hailort_${version}_arm64.deb || {
            echo "Failed to download from the second alternative URL. Exiting."
            exit 1
        }
    }
}

# Function to execute commands and catch errors
function try {
    "$@" || catch
}

# Use the try function to execute commands
try wget http://archive.raspberrypi.com/debian/pool/main/h/hailort/hailort_${version}_arm64.deb

#check if hailort is installed
if(hailortcli fw-control identify); then
    hailortcli fw-control identify
else
    echo "Hailo device is not detected, something went wrong"
fi