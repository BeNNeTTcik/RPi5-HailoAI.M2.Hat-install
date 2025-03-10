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
        else
            echo "Last chance"
            if wget -q "http://archive.raspberrypi.com/debian/pool/main/h/hailort/hailort_${hailort//\"/}-3_$(dpkg --print-architecture).deb"; then
                install_file="hailort_${hailort//\"/}-3_$(dpkg --print-architecture).deb"
	    else
                echo "Failed to download from the second alternative URL. Exiting."
                exit 1
            fi
        fi
    fi
}

function ask_continue {
    while true; do
        echo "Next script is a TAPPAS installation."
        read -r -p "Do you want to continue? (y/n)" answer
        answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
        
        if [[ "$answer" == "y" ]]; then
            echo "Continuing with the next script ..."
            ./TAPPAS_install.sh
            break
        elif [[ "$answer" == "n" ]]; then
            echo "Exiting script."
            exit 0
        else
            echo "Invalid input. Please enter 'y' or 'n'."
        fi
    done
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

#check if hailort is installed
if(hailortcli fw-control identify); then
    echo "Ready!!"
else
    echo "Hailo device is not detected, something went wrong"
fi

ask_continue
