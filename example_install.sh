#!/bin/bash
#read variables
if [ -f version.txt ]; then
    hailort=$(awk -F'=' '/^hailort=/{print $2}' version.txt)
    echo "PYHailoRT: $hailort"
else
    echo "Sth wrong"
fi

#variables:
#file="$HOME/Downloads/hailort-${hailort//\"/}-cp311-cp311-linux_aarch64.whl"

#hailort python3.11 lib
#cd $HOME
#sudo mkdir -p hailo
#sudo chown -R $USER: $HOME
#cd hailo
#virtualenv -p python3.11 hailo_venv
#. hailo_venv/bin/activate
#if [ -f "$plik" ]; then
#    echo "Installation" 
#    pip install .$HOME/Downloads/hailort-${hailort//\"/}-cp311-cp311-linux_aarch64.whl ###################################### ERROR
#else
#    echo "ERROR"
#fi

#repository application
cd $HOME
sudo mkdir -p hailo
sudo chown -R $USER: $HOME hailo
cd "$HOME/hailo"
git clone https://github.com/hailo-ai/Hailo-Application-Code-Examples.git

#repository example
cd "$HOME/hailo"
git clone https://github.com/hailo-ai/hailo-rpi5-examples.git
sudo chmod +w hailo-rpi5-examples
#sudo chown -R $(whoami): $(whoami) hailo-rpi5-examples
cd hailo-rpi5-examples
python3.11 -m venv venv_hailo_rpi5_examples
source venv_hailo_rpi5_examples/bin/activate
pip install --upgrade pip
./install.sh
source setup_env.sh
#python basic_pipelines/detection.py
