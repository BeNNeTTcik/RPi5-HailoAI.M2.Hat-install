#!/bin/bash

#read variables
if [ -f version.txt ]; then
    tappas=$(awk -F'=' '/^tappas=/{print $2}' version.txt)
    echo "tappas: $tappas"
else
    echo "Sth wrong"
fi

function ask_continue {
    while true; do
        echo "Next script is a DataFlow installation."
        read -r -p "Do you want to continue? (y/n)" answer
        answer=$(echo "$answer" | tr '[:upper:]' '[:lower:]')
        
        if [[ "$answer" == "y" ]]; then
            echo "Continuing with the next script ..."
            ./TAPPAS_install.sh
            break
        elif [[ "$answer" == "n" ]]; then
	    echo "Maybe the example_rpi installation."
            read -r -p "Do you want to continue? (y/n)" answer2
            answer2=$(echo "$answer2" | tr '[:upper:]' '[:lower:]')
            if [[ "$answer2" == "y" ]]; then
                echo "Continuing with the next script ..."
                ./example_install.sh
                break
            elif [[ "$answer2" == "n" ]]; then
                echo "Exiting script."
                exit 0
            fi
        else
            echo "Invalid input. Please enter 'y' or 'n'."
        fi
    done
}

function python_install {
#python3.11 install
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install curl python3.11 python3.11-venv python3.11-dev python3.11-distutils python3-tk graphviz libgraphviz-dev Pyrebase4 -y
}

python_install
#cd $HOME/RPi5-HailoAI.M2.Hat-install-main
#git clone https://github.com/hailo-ai/tappas.git --branch v${hailort//\"/}




new="3.28.0"
cd $HOME/RPi5-HailoAI.M2.Hat-install-main
if [[ "$tapas" != "$new" ]]; then
    wget https://archive.raspberrypi.com/debian/pool/main/h/hailo-tappas-core/hailo-tappas-core_${tappas//\"/}-1ar_$(dpkg --print-architecture).deb
    sudo apt install ./hailo-tappas-core_${tappas//\"/}-1_$(dpkg --print-architecture).deb -y
else
    wget https://archive.raspberrypi.com/debian/pool/main/h/hailo-tappas-core-3.28.2/hailo-tappas-core-3.28.2_3.28.2_$(dpkg --print-architecture).deb
    sudo apt install ./hailo-tappas-core-3.28.2_3.28.2_$(dpkg --print-architecture).deb -y
fi

ask_continue
