#!/bin/bash

#read variables
if [ -f version.txt ]; then
    tappas=$(awk -F'=' '/^tappas=/{print $2}' version.txt)
    echo "tappas: $tappas"
else
    echo "Sth wrong"
fi

new="3.28.0"
cd "$HOME/RPi5-HailoAI.M2.Hat-install-main"
if [[ "$tapas" != "$new" ]]; then
    wget https://archive.raspberrypi.com/debian/pool/main/h/hailo-tappas-core/hailo-tappas-core_${tappas//\"/}-1_$(dpkg --print-architecture).deb
    sudo apt install ./hailo-tappas-core_${tappas//\"/}-1_$(dpkg --print-architecture).deb -y
else
    wget https://archive.raspberrypi.com/debian/pool/main/h/hailo-tappas-core-3.28.2/hailo-tappas-core-3.28.2_3.28.2_$(dpkg --print-architecture).deb
    sudo apt install ./hailo-tappas-core-3.28.2_3.28.2_$(dpkg --print-architecture).deb -y
fi
