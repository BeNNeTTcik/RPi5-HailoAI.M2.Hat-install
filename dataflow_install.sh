#!/bin/bash

#read variables
if [ -f version.txt ]; then
    dataflow=$(awk -F'=' '/^dataflow_compiler=/{print $2}' version.txt)
    echo "Dataflow_compiler: $dataflow"
else
    echo "Sth wrong"
fi

#python3.10 install
sudo apt install software-properties-common -y
sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install curl python3.10 python3.10-venv python3.10-dev python3.10-distutils python3-tk graphviz libgraphviz-dev -y
ls -la /usr/bin/python3
sudo rm /usr/bin/python3
sudo ln -s python3.10 /usr/bin/python3
curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

echo "Install Dataflow_compiler"
cd "$HOME"
virtualenv -p python3.10 hailo
. hailo/bin/activate
cd ..
cd RPi5-HailoAI.M2.Hat-install-main
pip instal
virtualenv -p python3.10 test && . hailo_platfor
